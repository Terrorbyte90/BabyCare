import XCTest
@testable import Ljusglimt

final class VaccinationTests: XCTestCase {

    func test_vaccinationSchedule_hasAtLeast10Entries() {
        XCTAssertGreaterThanOrEqual(VaccinationData.schedule.count, 10)
    }

    func test_firstVaccination_isWithinFirstWeeks() {
        let first = VaccinationData.schedule.sorted { $0.ageInDays < $1.ageInDays }.first
        XCTAssertNotNil(first)
        XCTAssertLessThanOrEqual(first!.ageInDays, 90, "Första vaccination bör ges inom 3 månader")
    }

    func test_allEntries_haveNonEmptyNames() {
        for entry in VaccinationData.schedule {
            XCTAssertFalse(entry.vaccineName.isEmpty, "Vaccinnamn saknas för entry \(entry.id)")
        }
    }
}
