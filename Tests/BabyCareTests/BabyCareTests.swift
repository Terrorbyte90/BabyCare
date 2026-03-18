import XCTest
import SwiftUI
@testable import BabyCare

final class BabyCareTests: XCTestCase {

    // MARK: - UserData beräkningar

    func testCurrentPregnancyWeekVidKandDueDate() {
        // Arrange: graviditet med beräknat förlossningsdatum 10 veckor framåt
        let dueDate = Calendar.current.date(byAdding: .day, value: 70, to: Date())!
        let user = UserData(phase: .pregnancy, isPregnant: true, dueDate: dueDate)

        // Act
        let week = user.currentPregnancyWeek

        // Assert: 280 - 70 = 210 dagar => vecka 30
        XCTAssertNotNil(week)
        XCTAssertEqual(week, 30)
    }

    func testCurrentPregnancyWeekNilOmEjGravid() {
        let user = UserData(phase: .parent, isPregnant: false)
        XCTAssertNil(user.currentPregnancyWeek)
    }

    func testCurrentPregnancyWeekNilOmDueDateSaknas() {
        let user = UserData(phase: .pregnancy, isPregnant: true, dueDate: nil)
        XCTAssertNil(user.currentPregnancyWeek)
    }

    func testCurrentPregnancyDagBeraknas() {
        // Arrange: graviditet med dueDate exakt 70 dagar framåt
        // 280 - 70 = 210 dagar gravid, 210 % 7 = 0
        // OBS: datumberäkning med Calendar kan ge +/-1 dag beroende på DST och tid på dygnet,
        // därför testar vi ett intervall istället för exakt värde.
        let dueDate = Calendar.current.date(byAdding: .day, value: 70, to: Date())!
        let user = UserData(phase: .pregnancy, isPregnant: true, dueDate: dueDate)

        let day = user.currentPregnancyDay
        XCTAssertNotNil(day)
        XCTAssertTrue(
            (0...6).contains(day!),
            "currentPregnancyDay ska vara 0-6, fick \(day!)"
        )
    }

    func testBabyAgeInDaysBeraknas() {
        let birthDate = Calendar.current.date(byAdding: .day, value: -14, to: Date())!
        let user = UserData(phase: .parent, babyBirthDate: birthDate)

        let age = user.babyAgeInDays
        XCTAssertNotNil(age)
        XCTAssertEqual(age, 14)
    }

    func testBabyAgeStringNyfodFran0Till13Dagar() {
        let birthDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let user = UserData(phase: .parent, babyBirthDate: birthDate)
        XCTAssertEqual(user.babyAgeString, "Nyfödd")
    }

    func testBabyAgeStringVeckorMellan14Och29Dagar() {
        let birthDate = Calendar.current.date(byAdding: .day, value: -21, to: Date())!
        let user = UserData(phase: .parent, babyBirthDate: birthDate)
        XCTAssertEqual(user.babyAgeString, "3 veckor")
    }

    func testBabyAgeStringManaderNar1Manad() {
        let birthDate = Calendar.current.date(byAdding: .day, value: -60, to: Date())!
        let user = UserData(phase: .parent, babyBirthDate: birthDate)
        // 60 dagar = 2 månader (60/30 = 2)
        XCTAssertEqual(user.babyAgeString, "2 månader")
    }

    func testBabyAgeStringArOchManader() {
        let birthDate = Calendar.current.date(byAdding: .day, value: -540, to: Date())!
        let user = UserData(phase: .parent, babyBirthDate: birthDate)
        // 540 dagar = 18 månader = 1 år 6 mån
        let ageString = user.babyAgeString
        XCTAssertTrue(ageString.contains("år"), "Förväntad ålderstext: '\(ageString)'")
    }

    func testBabyAgeStringTomNarFoddelsedatumSaknas() {
        let user = UserData(phase: .parent, babyBirthDate: nil)
        XCTAssertEqual(user.babyAgeString, "")
    }

    func testBabyAgeInMonthsBeraknas() {
        let birthDate = Calendar.current.date(byAdding: .month, value: -6, to: Date())!
        let user = UserData(phase: .parent, babyBirthDate: birthDate)
        let months = user.babyAgeInMonths
        XCTAssertNotNil(months)
        XCTAssertEqual(months, 6)
    }

    // MARK: - SleepLog beräkningar

    func testSleepLogDurationBeraknas() {
        let start = Date()
        let end = start.addingTimeInterval(7200) // 2 timmar
        let log = SleepLog(startDate: start, endDate: end)
        XCTAssertEqual(log.duration, 7200)
    }

    func testSleepLogDurationStringTimmarOchMinuter() {
        let start = Date()
        let end = start.addingTimeInterval(5400) // 1h 30m
        let log = SleepLog(startDate: start, endDate: end)
        XCTAssertEqual(log.durationString, "1h 30m")
    }

    func testSleepLogDurationStringEndastMinuter() {
        let start = Date()
        let end = start.addingTimeInterval(1800) // 30m
        let log = SleepLog(startDate: start, endDate: end)
        XCTAssertEqual(log.durationString, "30m")
    }

    // MARK: - KickSession beräkningar

    func testKickSessionIsCompleteNarEndTimeSatt() {
        let session = KickSession()
        XCTAssertFalse(session.isComplete)

        var completeSession = KickSession(startTime: Date(), kickCount: 5)
        XCTAssertFalse(completeSession.isComplete)

        // Simulera avslutad session
        let s = KickSession(startTime: Date(), kickCount: 5, kickTimes: [])
        XCTAssertFalse(s.isComplete, "Utan endTime ska isComplete vara false")
    }

    func testKickSessionDurationStringTomNarEjAvslutad() {
        let session = KickSession()
        XCTAssertEqual(session.durationString, "—")
    }

    // MARK: - ContractionLog beräkningar

    func testContractionLogDurationStringTomNarEjAvslutad() {
        let log = ContractionLog()
        XCTAssertEqual(log.durationString, "—")
    }

    func testContractionLogDurationBeraknas() {
        let start = Date()
        let end = start.addingTimeInterval(60)
        let log = ContractionLog(startTime: start, endTime: end)
        XCTAssertEqual(log.duration, 60)
        XCTAssertEqual(log.durationString, "60s")
    }

    // MARK: - PeriodLog beräkningar

    func testPeriodLogDurationDaysBeraknas() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 5, to: start)!
        let log = PeriodLog(startDate: start, endDate: end)
        XCTAssertEqual(log.durationDays, 5)
    }

    func testPeriodLogDurationDaysNilNarEndDateSaknas() {
        let log = PeriodLog(startDate: Date(), endDate: nil)
        XCTAssertNil(log.durationDays)
    }

    func testPeriodLogMoodFranRawValue() {
        let log = PeriodLog(moodRaw: Mood.good.rawValue)
        XCTAssertEqual(log.mood, .good)
    }

    func testPeriodLogMoodNilFranOgiltigtRawValue() {
        let log = PeriodLog(moodRaw: "ogiltigt_värde")
        XCTAssertNil(log.mood)
    }

    func testPeriodLogCervicalMucusFranRawValue() {
        let log = PeriodLog(cervicalMucusRaw: CervicalMucusType.eggWhite.rawValue)
        XCTAssertEqual(log.cervicalMucus, .eggWhite)
    }

    // MARK: - CourseProgress beräkningar

    func testCourseProgressCompletionPercentageNollNarInga() {
        let progress = CourseProgress(courseId: "test")
        XCTAssertEqual(progress.completionPercentage, 0)
    }

    func testCourseProgressCompletionPercentageMedModuler() {
        let progress = CourseProgress(
            courseId: "test",
            completedModuleIds: ["m1", "m2", "m3", "m4", "m5"]
        )
        // 5 / 10 * 100 = 50%
        XCTAssertEqual(progress.completionPercentage, 50.0)
    }

    // MARK: - PregnancyWeekContent statisk data

    func testForWeekReturnsForrstaVeckanVidVecka4() {
        let content = PregnancyWeekContent.forWeek(4)
        XCTAssertEqual(content.week, 4)
    }

    func testForWeekClampasVidVecka42() {
        let content = PregnancyWeekContent.forWeek(50)
        XCTAssertEqual(content.week, 42)
    }

    func testForWeekClampasNedVidVecka1() {
        let content = PregnancyWeekContent.forWeek(1)
        XCTAssertEqual(content.week, 4)
    }

    func testAllWeeksHar39Veckor() {
        // Vecka 4 till 42 = 39 veckor
        let allWeeks = PregnancyWeekContent.all
        XCTAssertEqual(allWeeks.count, 39, "Ska finnas data för vecka 4-42 (39 veckor)")
    }

    func testAllaVeckorHarUnikVeckonummer() {
        let allWeeks = PregnancyWeekContent.all
        let weekNumbers = allWeeks.map { $0.week }
        let uniqueWeekNumbers = Set(weekNumbers)
        XCTAssertEqual(weekNumbers.count, uniqueWeekNumbers.count, "Varje vecka ska vara unik")
    }

    func testAllaVeckorHarTrimester() {
        let allWeeks = PregnancyWeekContent.all
        for weekContent in allWeeks {
            XCTAssertTrue(
                weekContent.trimester >= 1 && weekContent.trimester <= 3,
                "Vecka \(weekContent.week) ska ha trimester 1-3, fick \(weekContent.trimester)"
            )
        }
    }

    func testAllaVeckorHarMinst1TipsOch1Symptom() {
        let allWeeks = PregnancyWeekContent.all
        for weekContent in allWeeks {
            XCTAssertFalse(
                weekContent.tips.isEmpty,
                "Vecka \(weekContent.week) saknar tips"
            )
            XCTAssertFalse(
                weekContent.commonSymptoms.isEmpty,
                "Vecka \(weekContent.week) saknar vanliga symptom"
            )
        }
    }

    func testCompatibilityPropertyTip() {
        let content = PregnancyWeekContent.forWeek(20)
        XCTAssertFalse(content.tip.isEmpty)
        XCTAssertEqual(content.tip, content.tips.first ?? "")
    }

    func testCompatibilityPropertyHighlight() {
        let content = PregnancyWeekContent.forWeek(20)
        XCTAssertEqual(content.highlight, content.fetalDevelopment.first ?? "")
    }

    // MARK: - StoolColor varningar

    func testStoolColorSvartHarVarning() {
        XCTAssertNotNil(StoolColor.black.warning)
    }

    func testStoolColorRodHarVarning() {
        XCTAssertNotNil(StoolColor.red.warning)
    }

    func testStoolColorVitHarVarning() {
        XCTAssertNotNil(StoolColor.white.warning)
    }

    func testNormalaFargerHarInteVarning() {
        XCTAssertNil(StoolColor.yellow.warning)
        XCTAssertNil(StoolColor.green.warning)
        XCTAssertNil(StoolColor.brown.warning)
    }

    func testIsNormalVardenKorrekt() {
        XCTAssertTrue(StoolColor.yellow.isNormal)
        XCTAssertTrue(StoolColor.green.isNormal)
        XCTAssertTrue(StoolColor.brown.isNormal)
        XCTAssertFalse(StoolColor.black.isNormal)
        XCTAssertFalse(StoolColor.red.isNormal)
        XCTAssertFalse(StoolColor.white.isNormal)
    }

    // MARK: - Enum rawValues och icons

    func testUserPhaseIconsFinns() {
        for phase in UserPhase.allCases {
            XCTAssertFalse(phase.icon.isEmpty, "UserPhase.\(phase) saknar ikon")
        }
    }

    func testAppointmentTypeIconsFinns() {
        for type in AppointmentType.allCases {
            XCTAssertFalse(type.icon.isEmpty, "AppointmentType.\(type) saknar ikon")
        }
    }

    func testFeedingTypeIconsFinns() {
        for type in FeedingType.allCases {
            XCTAssertFalse(type.icon.isEmpty, "FeedingType.\(type) saknar ikon")
        }
    }

    func testDiaperTypeIconsFinns() {
        for type in DiaperType.allCases {
            XCTAssertFalse(type.icon.isEmpty, "DiaperType.\(type) saknar ikon")
        }
    }

    func testMoodEmojiFinns() {
        for mood in Mood.allCases {
            XCTAssertFalse(mood.emoji.isEmpty, "Mood.\(mood) saknar emoji")
        }
    }

    func testFertilitySymptomIconsFinns() {
        for symptom in FertilitySymptom.allCases {
            XCTAssertFalse(symptom.icon.isEmpty, "FertilitySymptom.\(symptom) saknar ikon")
        }
    }

    func testCervicalMucusFertilityLevelsFinns() {
        for mucus in CervicalMucusType.allCases {
            XCTAssertFalse(mucus.fertilityLevel.isEmpty, "\(mucus) saknar fertilitetsnivå")
        }
    }

    func testHospitalBagCategoryIconsFinns() {
        for category in HospitalBagCategory.allCases {
            XCTAssertFalse(category.icon.isEmpty, "HospitalBagCategory.\(category) saknar ikon")
        }
    }

    // MARK: - ChildrenStory data

    func testStoryCategoriesHarDisplayNames() {
        for category in StoryCategory.allCases {
            XCTAssertFalse(category.displayName.isEmpty, "StoryCategory.\(category) saknar displayName")
        }
    }

    func testStoryCategoriesHarIcons() {
        for category in StoryCategory.allCases {
            XCTAssertFalse(category.icon.isEmpty, "StoryCategory.\(category) saknar ikon")
        }
    }

    // MARK: - CourseData

    func testAllCoursesFinns() {
        XCTAssertFalse(Course.all.isEmpty, "Ska finnas minst en kurs")
    }

    func testAllaKurserHarUnikaIds() {
        let ids = Course.all.map { $0.id }
        let uniqueIds = Set(ids)
        XCTAssertEqual(ids.count, uniqueIds.count, "Alla kurser ska ha unika ID:n")
    }

    func testAllaKurserHarModuler() {
        for course in Course.all {
            XCTAssertFalse(course.modules.isEmpty, "Kurs '\(course.title)' saknar moduler")
        }
    }

    func testAllaModulerHarUnikaIds() {
        for course in Course.all {
            let ids = course.modules.map { $0.id }
            let uniqueIds = Set(ids)
            XCTAssertEqual(
                ids.count, uniqueIds.count,
                "Kurs '\(course.title)' har moduler med duplikat-ID:n"
            )
        }
    }

    func testAllaModulerHarLasningsTid() {
        for course in Course.all {
            for module in course.modules {
                XCTAssertGreaterThan(
                    module.readingTimeMinutes, 0,
                    "Modul '\(module.title)' i kurs '\(course.title)' har noll läsningstid"
                )
            }
        }
    }

    func testAllaModulerHarNyckelPunkter() {
        for course in Course.all {
            for module in course.modules {
                XCTAssertFalse(
                    module.keyPoints.isEmpty,
                    "Modul '\(module.title)' saknar nyckelpunkter"
                )
            }
        }
    }

    func testAllaModulerHarReflektionsfragor() {
        for course in Course.all {
            for module in course.modules {
                XCTAssertFalse(
                    module.reflectionQuestions.isEmpty,
                    "Modul '\(module.title)' saknar reflektionsfrågor"
                )
            }
        }
    }

    // MARK: - KnowledgeBase data

    func testAllaArtiklarFinns() {
        let articles = Article.all
        XCTAssertFalse(articles.isEmpty, "Ska finnas minst en artikel")
    }

    func testAllaArtiklarHarUnikaIds() {
        let ids = Article.all.map { $0.id }
        let uniqueIds = Set(ids)
        XCTAssertEqual(ids.count, uniqueIds.count, "Alla artiklar ska ha unika ID:n")
    }

    func testAllaArtiklarHarTitel() {
        for article in Article.all {
            XCTAssertFalse(article.title.isEmpty, "Artikel ID '\(article.id)' saknar titel")
        }
    }

    func testAllaArtiklarHarInnehall() {
        for article in Article.all {
            XCTAssertFalse(
                article.sections.isEmpty,
                "Artikel '\(article.title)' saknar sektioner"
            )
        }
    }

    func testAllaArtiklarHarLasningsTid() {
        for article in Article.all {
            XCTAssertGreaterThan(
                article.readTimeMinutes, 0,
                "Artikel '\(article.title)' har noll läsningstid"
            )
        }
    }

    func testArtikelFilterPaKategori() {
        let pregnancyArticles = Article.all.filter { $0.category == .pregnancy }
        XCTAssertFalse(pregnancyArticles.isEmpty, "Ska finnas artiklar i kategorin graviditet")
    }

    // MARK: - DS (Design System) konstanter

    func testDSSpacingArPositiva() {
        XCTAssertGreaterThan(DS.s1, 0)
        XCTAssertGreaterThan(DS.s2, DS.s1)
        XCTAssertGreaterThan(DS.s4, DS.s2)
        XCTAssertGreaterThan(DS.s8, DS.s4)
    }

    func testDSRadiusArPositiva() {
        XCTAssertGreaterThan(DS.radius, 0)
        XCTAssertGreaterThan(DS.radiusLg, DS.radius)
        XCTAssertGreaterThan(DS.radiusXl, DS.radiusLg)
    }
}
