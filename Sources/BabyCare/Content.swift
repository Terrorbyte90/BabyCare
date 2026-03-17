import SwiftUI

// MARK: - Milestone Category

enum MilestoneCategory: String, CaseIterable {
    case social    = "Social"
    case motor     = "Motor"
    case language  = "Language"
    case cognitive = "Cognitive"

    var icon: String {
        switch self {
        case .social:    return "heart.fill"
        case .motor:     return "figure.walk"
        case .language:  return "bubble.fill"
        case .cognitive: return "brain.head.profile"
        }
    }

    var gradient: LinearGradient {
        switch self {
        case .social:    return .pinkPurple
        case .motor:     return .greenTeal
        case .language:  return .blueIndigo
        case .cognitive: return .orangePink
        }
    }

    var color: Color {
        switch self {
        case .social:    return .appPink
        case .motor:     return .appGreen
        case .language:  return .appBlue
        case .cognitive: return .appOrange
        }
    }
}

// MARK: - Milestone Item

struct MilestoneItem: Identifiable {
    let id: String
    let title: String
    let description: String
    let ageMonthsMin: Int
    let ageMonthsMax: Int
    let icon: String
    let category: MilestoneCategory

    static let all: [MilestoneItem] = [
        // Social
        MilestoneItem(id: "social_smile",    title: "First Social Smile",        description: "Smiles responsively at your face or voice",             ageMonthsMin: 1,  ageMonthsMax: 3,  icon: "face.smiling.fill",                  category: .social),
        MilestoneItem(id: "social_laugh",    title: "First Laugh",               description: "Laughs or giggles out loud",                            ageMonthsMin: 3,  ageMonthsMax: 5,  icon: "face.smiling.fill",                  category: .social),
        MilestoneItem(id: "social_stranger", title: "Stranger Awareness",        description: "Shows clear preference for familiar faces",             ageMonthsMin: 6,  ageMonthsMax: 9,  icon: "person.2.fill",                      category: .social),
        MilestoneItem(id: "social_wave",     title: "Waves Bye-Bye",             description: "Waves or claps hands when prompted",                    ageMonthsMin: 9,  ageMonthsMax: 12, icon: "hand.wave.fill",                     category: .social),
        MilestoneItem(id: "social_play",     title: "Plays with Others",         description: "Plays alongside or interacts with other children",      ageMonthsMin: 18, ageMonthsMax: 24, icon: "person.3.fill",                      category: .social),
        // Motor
        MilestoneItem(id: "motor_head",      title: "Holds Head Steady",         description: "Lifts and holds head up during tummy time",             ageMonthsMin: 1,  ageMonthsMax: 4,  icon: "figure.child",                       category: .motor),
        MilestoneItem(id: "motor_roll",      title: "Rolls Over",                description: "Rolls from tummy to back or back to tummy",            ageMonthsMin: 3,  ageMonthsMax: 6,  icon: "arrow.2.circlepath",                 category: .motor),
        MilestoneItem(id: "motor_sit_sup",   title: "Sits with Support",         description: "Sits upright with minimal assistance",                 ageMonthsMin: 4,  ageMonthsMax: 6,  icon: "figure.child",                       category: .motor),
        MilestoneItem(id: "motor_sit_free",  title: "Sits Independently",        description: "Sits without support for several seconds",             ageMonthsMin: 6,  ageMonthsMax: 9,  icon: "figure.child",                       category: .motor),
        MilestoneItem(id: "motor_crawl",     title: "Starts Crawling",           description: "Crawls on hands and knees",                            ageMonthsMin: 7,  ageMonthsMax: 10, icon: "figure.child.and.lock",              category: .motor),
        MilestoneItem(id: "motor_pullup",    title: "Pulls to Stand",            description: "Pulls up to standing using furniture",                 ageMonthsMin: 8,  ageMonthsMax: 11, icon: "arrow.up.circle.fill",               category: .motor),
        MilestoneItem(id: "motor_steps",     title: "First Independent Steps",   description: "Takes first steps without support",                    ageMonthsMin: 10, ageMonthsMax: 14, icon: "figure.walk",                        category: .motor),
        MilestoneItem(id: "motor_walks",     title: "Walks Steadily",            description: "Walks independently and confidently",                  ageMonthsMin: 12, ageMonthsMax: 18, icon: "figure.walk",                        category: .motor),
        MilestoneItem(id: "motor_runs",      title: "Starts Running",            description: "Runs, though may fall sometimes",                      ageMonthsMin: 14, ageMonthsMax: 20, icon: "figure.run",                         category: .motor),
        // Language
        MilestoneItem(id: "lang_coos",       title: "Cooing Sounds",             description: "Makes soft vowel sounds ('ooh', 'aah')",               ageMonthsMin: 1,  ageMonthsMax: 3,  icon: "bubble.fill",                        category: .language),
        MilestoneItem(id: "lang_babble",     title: "Babbling",                  description: "Strings sounds together ('ba-ba', 'da-da')",           ageMonthsMin: 4,  ageMonthsMax: 7,  icon: "bubble.left.and.bubble.right.fill",  category: .language),
        MilestoneItem(id: "lang_name",       title: "Responds to Name",          description: "Turns or looks when called by name",                   ageMonthsMin: 5,  ageMonthsMax: 8,  icon: "ear.fill",                           category: .language),
        MilestoneItem(id: "lang_word",       title: "First Meaningful Word",     description: "Says first clear, intentional word",                   ageMonthsMin: 9,  ageMonthsMax: 14, icon: "quote.bubble.fill",                  category: .language),
        MilestoneItem(id: "lang_phrase",     title: "Two-Word Phrases",          description: "Combines two words ('more milk', 'daddy go')",         ageMonthsMin: 16, ageMonthsMax: 24, icon: "text.bubble.fill",                   category: .language),
        // Cognitive
        MilestoneItem(id: "cog_tracks",      title: "Tracks Moving Objects",     description: "Follows moving objects smoothly with eyes",            ageMonthsMin: 1,  ageMonthsMax: 3,  icon: "eye.fill",                           category: .cognitive),
        MilestoneItem(id: "cog_reaches",     title: "Reaches for Objects",       description: "Intentionally reaches and grasps toys",               ageMonthsMin: 3,  ageMonthsMax: 5,  icon: "hand.raised.fill",                   category: .cognitive),
        MilestoneItem(id: "cog_transfers",   title: "Hand-to-Hand Transfer",     description: "Passes objects from one hand to the other",           ageMonthsMin: 5,  ageMonthsMax: 7,  icon: "arrow.left.arrow.right",             category: .cognitive),
        MilestoneItem(id: "cog_permanence",  title: "Object Permanence",         description: "Searches for hidden or dropped objects",              ageMonthsMin: 7,  ageMonthsMax: 10, icon: "eyes",                               category: .cognitive),
        MilestoneItem(id: "cog_points",      title: "Points to Show Interest",   description: "Points at objects or pictures to share interest",     ageMonthsMin: 10, ageMonthsMax: 14, icon: "hand.point.right.fill",              category: .cognitive),
        MilestoneItem(id: "cog_pretend",     title: "Pretend Play",              description: "Engages in simple pretend play (feeding a doll)",     ageMonthsMin: 12, ageMonthsMax: 18, icon: "sparkles",                           category: .cognitive),
    ]
}

// MARK: - Pregnancy Week Content

struct PregnancyWeekContent {
    let week: Int
    let sizeEmoji: String
    let sizeComparison: String
    let highlight: String
    let tip: String

    static func forWeek(_ week: Int) -> PregnancyWeekContent {
        let clamped = min(max(week, 4), 40)
        return all.first { $0.week == clamped } ?? all[0]
    }

    static let all: [PregnancyWeekContent] = [
        PregnancyWeekContent(week: 4,  sizeEmoji: "🌱", sizeComparison: "Poppy seed",         highlight: "Implantation complete. Neural tube forming.",                    tip: "Start prenatal vitamins with folic acid if you haven't already."),
        PregnancyWeekContent(week: 5,  sizeEmoji: "🫘", sizeComparison: "Sesame seed",        highlight: "Heart begins to beat — about 150 bpm.",                          tip: "Avoid alcohol, raw fish, and limit caffeine to 200 mg/day."),
        PregnancyWeekContent(week: 6,  sizeEmoji: "🫘", sizeComparison: "Lentil",             highlight: "Brain, spinal cord, and organs forming rapidly.",                tip: "Morning sickness? Try ginger tea and small, frequent meals."),
        PregnancyWeekContent(week: 7,  sizeEmoji: "🫐", sizeComparison: "Blueberry",          highlight: "Webbed fingers and toes forming.",                               tip: "Schedule your first prenatal appointment if you haven't yet."),
        PregnancyWeekContent(week: 8,  sizeEmoji: "🍓", sizeComparison: "Raspberry",          highlight: "All essential organs have started forming.",                     tip: "You may feel more fatigued than usual — rest whenever you can."),
        PregnancyWeekContent(week: 9,  sizeEmoji: "🍇", sizeComparison: "Grape",              highlight: "Baby moves inside you — though you can't feel it yet.",          tip: "Gentle prenatal yoga or daily walks can really boost your energy."),
        PregnancyWeekContent(week: 10, sizeEmoji: "🍊", sizeComparison: "Kumquat",            highlight: "Baby graduates from embryo to fetus!",                           tip: "Miscarriage risk drops significantly this week — a big milestone."),
        PregnancyWeekContent(week: 11, sizeEmoji: "🫑", sizeComparison: "Fig",                highlight: "Baby can open/close fists and hiccup.",                          tip: "NIPT blood test and nuchal scan are often offered around now."),
        PregnancyWeekContent(week: 12, sizeEmoji: "🍋", sizeComparison: "Lime",               highlight: "Fingerprints forming. Baby can suck their thumb.",               tip: "Many share their news at 12 weeks — congrats if you're ready!"),
        PregnancyWeekContent(week: 13, sizeEmoji: "🫛", sizeComparison: "Pea pod",            highlight: "Vocal cords developing. Facial features forming.",               tip: "Welcome to the 2nd trimester! Energy often improves now."),
        PregnancyWeekContent(week: 14, sizeEmoji: "🍋", sizeComparison: "Lemon",              highlight: "Baby makes facial expressions including squinting.",             tip: "Moisturize your belly daily to support skin elasticity."),
        PregnancyWeekContent(week: 15, sizeEmoji: "🍎", sizeComparison: "Apple",              highlight: "Baby is moving, kicking, and jumping inside.",                   tip: "You may feel the first flutters (quickening) very soon!"),
        PregnancyWeekContent(week: 16, sizeEmoji: "🥑", sizeComparison: "Avocado",            highlight: "Baby can hear sounds from outside the womb now.",               tip: "Talk, sing, and read aloud to baby — they can hear you!"),
        PregnancyWeekContent(week: 17, sizeEmoji: "🍐", sizeComparison: "Pear",               highlight: "Baby builds brown fat for warmth after birth.",                 tip: "Consider a pregnancy pillow for more comfortable sleep."),
        PregnancyWeekContent(week: 18, sizeEmoji: "🫑", sizeComparison: "Bell pepper",        highlight: "Baby can yawn and stretch. Ears are fully functional.",          tip: "Anatomy ultrasound is typically scheduled this week!"),
        PregnancyWeekContent(week: 19, sizeEmoji: "🍅", sizeComparison: "Heirloom tomato",    highlight: "Vernix (protective coating) covers baby's skin.",                tip: "Daily pelvic floor exercises now helps in labor and recovery."),
        PregnancyWeekContent(week: 20, sizeEmoji: "🍌", sizeComparison: "Banana",             highlight: "Halfway there! Baby's digestive system maturing.",               tip: "If you haven't felt kicks yet, you will very soon!"),
        PregnancyWeekContent(week: 21, sizeEmoji: "🥕", sizeComparison: "Carrot",             highlight: "Eyebrows and lashes growing. Taste buds forming.",               tip: "Start tracking kick patterns to learn your baby's rhythms."),
        PregnancyWeekContent(week: 22, sizeEmoji: "🥒", sizeComparison: "Spaghetti squash",   highlight: "Baby is beginning to look like a newborn.",                      tip: "Tour your birth center or hospital if you plan to deliver there."),
        PregnancyWeekContent(week: 23, sizeEmoji: "🥭", sizeComparison: "Mango",              highlight: "Baby responds to your voice with an increased heart rate.",      tip: "Research birthing options and consider taking a childbirth class."),
        PregnancyWeekContent(week: 24, sizeEmoji: "🌽", sizeComparison: "Corn",               highlight: "Viability milestone reached! Lungs developing surfactant.",      tip: "Glucose screening for gestational diabetes is typically this week."),
        PregnancyWeekContent(week: 25, sizeEmoji: "🥦", sizeComparison: "Cauliflower",        highlight: "Brain developing fast. Baby now responds to light.",             tip: "Third trimester is close — start thinking about your hospital bag."),
        PregnancyWeekContent(week: 26, sizeEmoji: "🥬", sizeComparison: "Head of lettuce",    highlight: "Eyelids can open and close. Fat deposits forming rapidly.",      tip: "Take a childbirth preparation class in the next few weeks."),
        PregnancyWeekContent(week: 27, sizeEmoji: "🫚", sizeComparison: "Rutabaga",           highlight: "Baby hears clearly and recognizes your voice.",                  tip: "Begin drafting your birth plan and discuss it with your provider."),
        PregnancyWeekContent(week: 28, sizeEmoji: "🍆", sizeComparison: "Eggplant",           highlight: "Third trimester begins! Baby has strong survival odds.",         tip: "Count kicks daily — aim for 10 movements in 2 hours."),
        PregnancyWeekContent(week: 29, sizeEmoji: "🧡", sizeComparison: "Butternut squash",   highlight: "Brain developing folds to increase surface area.",               tip: "Consider taking a breastfeeding class to prepare for after birth."),
        PregnancyWeekContent(week: 30, sizeEmoji: "🥬", sizeComparison: "Cabbage",            highlight: "Baby's eyes follow light. Sleep cycles are forming.",            tip: "Discuss your birth preferences in detail with your provider."),
        PregnancyWeekContent(week: 31, sizeEmoji: "🍑", sizeComparison: "Four oranges",       highlight: "Baby gains about half a pound per week from now on.",            tip: "Prepare your home — wash baby clothes, set up the nursery."),
        PregnancyWeekContent(week: 32, sizeEmoji: "🥥", sizeComparison: "Jicama",             highlight: "Baby practices breathing. May have hair growing.",               tip: "Pack your hospital bag — items for you, your partner, and baby."),
        PregnancyWeekContent(week: 33, sizeEmoji: "🍍", sizeComparison: "Pineapple",          highlight: "Immune system strengthening. Bones hardening.",                  tip: "Pre-register at your hospital or birth center to save time later."),
        PregnancyWeekContent(week: 34, sizeEmoji: "🍈", sizeComparison: "Cantaloupe",         highlight: "Central nervous system and lungs maturing fast.",                tip: "Group B Strep test is typically done around now — ask your provider."),
        PregnancyWeekContent(week: 35, sizeEmoji: "🥥", sizeComparison: "Coconut",            highlight: "Baby running out of room but still gaining weight daily.",       tip: "After week 37, baby could arrive any time — stay prepared!"),
        PregnancyWeekContent(week: 36, sizeEmoji: "🥗", sizeComparison: "Head of romaine",    highlight: "Baby drops lower in the pelvis — lightening!",                  tip: "Watch for early labor: bloody show, water breaking, contractions."),
        PregnancyWeekContent(week: 37, sizeEmoji: "🍉", sizeComparison: "Small watermelon",   highlight: "Early term! Lungs nearly ready to breathe air.",                 tip: "Hospital bag packed? Confirm your ride and birth team are ready."),
        PregnancyWeekContent(week: 38, sizeEmoji: "🧅", sizeComparison: "Leek",               highlight: "Brain still developing daily. Baby gaining weight.",             tip: "Rest while you can — labor is close. Sleep and eat well."),
        PregnancyWeekContent(week: 39, sizeEmoji: "🎃", sizeComparison: "Small pumpkin",      highlight: "Full term! All organs fully mature and ready.",                  tip: "Gentle walks can help prepare your body for labor."),
        PregnancyWeekContent(week: 40, sizeEmoji: "🎃", sizeComparison: "Large pumpkin",      highlight: "Your baby is ready for the outside world!",                     tip: "Your due date is here. Trust your body, your team, and the process."),
    ]
}

// MARK: - WHO Growth Reference Data

struct GrowthPoint {
    let month: Double
    let value: Double
}

enum WHOGrowthData {
    // Weight-for-age (kg) — combined average (P3 / P50 / P97)
    static let weightP3: [GrowthPoint] = [
        .init(month: 0,  value: 2.5),  .init(month: 1,  value: 3.4),  .init(month: 2,  value: 4.3),
        .init(month: 3,  value: 5.0),  .init(month: 4,  value: 5.6),  .init(month: 5,  value: 6.0),
        .init(month: 6,  value: 6.4),  .init(month: 7,  value: 6.7),  .init(month: 8,  value: 7.0),
        .init(month: 9,  value: 7.1),  .init(month: 10, value: 7.5),  .init(month: 11, value: 7.7),
        .init(month: 12, value: 7.8),  .init(month: 15, value: 8.4),  .init(month: 18, value: 8.8),
        .init(month: 21, value: 9.3),  .init(month: 24, value: 9.7),
    ]
    static let weightP50: [GrowthPoint] = [
        .init(month: 0,  value: 3.3),  .init(month: 1,  value: 4.5),  .init(month: 2,  value: 5.6),
        .init(month: 3,  value: 6.4),  .init(month: 4,  value: 7.0),  .init(month: 5,  value: 7.5),
        .init(month: 6,  value: 7.9),  .init(month: 7,  value: 8.3),  .init(month: 8,  value: 8.6),
        .init(month: 9,  value: 8.9),  .init(month: 10, value: 9.2),  .init(month: 11, value: 9.4),
        .init(month: 12, value: 9.6),  .init(month: 15, value: 10.3), .init(month: 18, value: 10.9),
        .init(month: 21, value: 11.5), .init(month: 24, value: 12.1),
    ]
    static let weightP97: [GrowthPoint] = [
        .init(month: 0,  value: 4.4),  .init(month: 1,  value: 5.8),  .init(month: 2,  value: 7.1),
        .init(month: 3,  value: 8.0),  .init(month: 4,  value: 8.7),  .init(month: 5,  value: 9.3),
        .init(month: 6,  value: 9.9),  .init(month: 7,  value: 10.3), .init(month: 8,  value: 10.7),
        .init(month: 9,  value: 11.0), .init(month: 10, value: 11.4), .init(month: 11, value: 11.7),
        .init(month: 12, value: 12.0), .init(month: 15, value: 12.9), .init(month: 18, value: 13.7),
        .init(month: 21, value: 14.5), .init(month: 24, value: 15.2),
    ]

    // Height/length-for-age (cm) — combined average (P3 / P50 / P97)
    static let heightP3: [GrowthPoint] = [
        .init(month: 0,  value: 46.3), .init(month: 2,  value: 54.4), .init(month: 4,  value: 59.9),
        .init(month: 6,  value: 63.6), .init(month: 9,  value: 67.7), .init(month: 12, value: 71.0),
        .init(month: 15, value: 73.8), .init(month: 18, value: 77.2), .init(month: 21, value: 80.0),
        .init(month: 24, value: 82.4),
    ]
    static let heightP50: [GrowthPoint] = [
        .init(month: 0,  value: 49.9), .init(month: 2,  value: 58.4), .init(month: 4,  value: 63.9),
        .init(month: 6,  value: 67.6), .init(month: 9,  value: 72.0), .init(month: 12, value: 75.7),
        .init(month: 15, value: 79.1), .init(month: 18, value: 82.3), .init(month: 21, value: 85.1),
        .init(month: 24, value: 87.8),
    ]
    static let heightP97: [GrowthPoint] = [
        .init(month: 0,  value: 53.4), .init(month: 2,  value: 62.4), .init(month: 4,  value: 68.0),
        .init(month: 6,  value: 71.6), .init(month: 9,  value: 76.2), .init(month: 12, value: 80.5),
        .init(month: 15, value: 84.4), .init(month: 18, value: 87.7), .init(month: 21, value: 90.4),
        .init(month: 24, value: 93.2),
    ]
}
