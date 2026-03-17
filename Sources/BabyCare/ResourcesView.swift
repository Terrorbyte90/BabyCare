import SwiftUI

// MARK: - Resources View

struct ResourcesView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        // Akut
                        emergencySection
                            .staggerAppear(index: 0)

                        // Stod
                        supportSection
                            .staggerAppear(index: 1)

                        // Vard
                        healthcareSection
                            .staggerAppear(index: 2)

                        // Praktiskt
                        practicalSection
                            .staggerAppear(index: 3)

                        // BVC Schema
                        bvcScheduleLink
                            .staggerAppear(index: 4)

                        Color.clear.frame(height: 90)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s3)
                }
            }
            .navigationTitle("Resurser")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Emergency Section

    private var emergencySection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Akut")

            VStack(spacing: DS.s2) {
                ResourceContactCard(
                    title: "SOS Alarm",
                    subtitle: "Livshotande nod -- ring omedelbart",
                    phone: "112",
                    icon: "phone.fill",
                    gradient: LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing),
                    isUrgent: true
                )

                ResourceContactCard(
                    title: "1177 Vardguiden",
                    subtitle: "Sjukvardsradgivning dygnet runt",
                    phone: "1177",
                    icon: "cross.case.fill",
                    gradient: .blueIndigo,
                    url: "https://www.1177.se"
                )

                ResourceContactCard(
                    title: "Giftinformationscentralen",
                    subtitle: "Vid misstankt forgiftning",
                    phone: "010-456 67 00",
                    icon: "exclamationmark.triangle.fill",
                    gradient: .orangePink
                )
            }
        }
    }

    // MARK: - Support Section

    private var supportSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Stod")

            VStack(spacing: DS.s2) {
                ResourceContactCard(
                    title: "BRIS",
                    subtitle: "Barnens ratt i samhallet -- stod for barn och foraldrar",
                    phone: "116 111",
                    icon: "heart.fill",
                    gradient: .pinkPurple,
                    url: "https://www.bris.se"
                )

                ResourceContactCard(
                    title: "Kvinnofridslinjen",
                    subtitle: "Stod vid vald i nara relationer",
                    phone: "020-50 50 50",
                    icon: "shield.fill",
                    gradient: .pregnancyGradient
                )

                ResourceContactCard(
                    title: "Mind Sjalvmordslinjen",
                    subtitle: "Stod vid sjalvmordstankar -- oppet dygnet runt",
                    phone: "90101",
                    icon: "hand.raised.fill",
                    gradient: .tealMint
                )
            }
        }
    }

    // MARK: - Healthcare Section

    private var healthcareSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Vard")

            VStack(spacing: DS.s2) {
                ResourceInfoCard(
                    title: "BVC -- Barnavardscentralen",
                    subtitle: "Gratis halsokontroller och vaccinationer for barn 0-6 ar. Kontakta din lokala vardcentral for att registrera ditt barn.",
                    icon: "figure.child",
                    gradient: .greenTeal,
                    url: "https://www.1177.se/barn--gravid/att-skota-ett-nyfott-barn/bvc/"
                )

                ResourceInfoCard(
                    title: "Modravardscentralen",
                    subtitle: "Kostnadsfri vard under graviditeten. Barnmorskemottagningar erbjuder kontroller, ultraljud och forlossningsforberande kurser.",
                    icon: "figure.pregnant",
                    gradient: .pinkPurple,
                    url: "https://www.1177.se/barn--gravid/graviditet/"
                )
            }
        }
    }

    // MARK: - Practical Section

    private var practicalSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Praktiskt")

            VStack(spacing: DS.s2) {
                ResourceInfoCard(
                    title: "Forsakringskassan -- Foraldrapenning",
                    subtitle: "480 dagar per barn att dela pa. Ansok i god tid och planera uttaget av dagar. Bada foraldrarna har ratt till foraldrapenning.",
                    icon: "creditcard.fill",
                    gradient: .warmGradient,
                    url: "https://www.forsakringskassan.se/privatperson/foralder"
                )

                ResourceInfoCard(
                    title: "Dagis / Forskola",
                    subtitle: "Barn fran 1 ars alder har ratt till forskoleplats. Ansok hos din kommun, vantetiderna varierar. Alla barn har ratt till 15 timmar i veckan fran 3 ars alder.",
                    icon: "building.fill",
                    gradient: .softGreen,
                    url: nil
                )
            }
        }
    }

    // MARK: - BVC Schedule Link

    private var bvcScheduleLink: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "BVC-schema")

            NavigationLink {
                BVCScheduleView()
            } label: {
                GradientCard(gradient: .blueIndigo) {
                    HStack(spacing: DS.s4) {
                        ZStack {
                            RoundedRectangle(cornerRadius: DS.radiusSm + 2)
                                .fill(Color.white.opacity(0.15))
                                .frame(width: 52, height: 52)

                            Image(systemName: "list.clipboard.fill")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundStyle(.white)
                        }

                        VStack(alignment: .leading, spacing: DS.s1) {
                            Text("Komplett BVC-schema")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)

                            Text("Alla besok, vaccinationer och kontroller 0-5 ar")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(.white.opacity(0.7))
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }
            }
            .buttonStyle(ScaleButtonStyle())
        }
    }
}

// MARK: - Resource Contact Card

private struct ResourceContactCard: View {
    let title: String
    let subtitle: String
    let phone: String
    let icon: String
    let gradient: LinearGradient
    var isUrgent: Bool = false
    var url: String? = nil

    var body: some View {
        GlassCard(gradient: gradient) {
            VStack(spacing: DS.s3) {
                HStack(spacing: DS.s3) {
                    IconBadge(icon: icon, gradient: gradient, size: 40)

                    VStack(alignment: .leading, spacing: DS.s1) {
                        HStack(spacing: DS.s2) {
                            Text(title)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)

                            if isUrgent {
                                Text("AKUT")
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.appRed)
                                    .clipShape(Capsule())
                            }
                        }

                        Text(subtitle)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color.appTextSec)
                            .lineSpacing(2)
                    }

                    Spacer()
                }

                HStack(spacing: DS.s2) {
                    // Call button
                    if let telURL = URL(string: "tel:\(phone.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: ""))") {
                        Link(destination: telURL) {
                            HStack(spacing: DS.s2) {
                                Image(systemName: "phone.fill")
                                    .font(.system(size: 12, weight: .semibold))

                                Text(phone)
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, DS.s2 + 2)
                            .background(gradient)
                            .clipShape(Capsule())
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }

                    // Website button
                    if let urlString = url, let webURL = URL(string: urlString) {
                        Link(destination: webURL) {
                            HStack(spacing: DS.s2) {
                                Image(systemName: "globe")
                                    .font(.system(size: 12, weight: .semibold))

                                Text("Webb")
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            .foregroundStyle(Color.appTextSec)
                            .padding(.horizontal, DS.s4)
                            .padding(.vertical, DS.s2 + 2)
                            .background(Color.appSurface2)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.appBorderMed, lineWidth: 1))
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
            }
        }
    }
}

// MARK: - Resource Info Card

private struct ResourceInfoCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let gradient: LinearGradient
    var url: String? = nil

    var body: some View {
        GlassCard(gradient: gradient) {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s3) {
                    IconBadge(icon: icon, gradient: gradient, size: 40)

                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Spacer()
                }

                Text(subtitle)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.appTextSec)
                    .lineSpacing(4)

                if let urlString = url, let webURL = URL(string: urlString) {
                    Link(destination: webURL) {
                        HStack(spacing: DS.s2) {
                            Image(systemName: "globe")
                                .font(.system(size: 12, weight: .semibold))

                            Text("Las mer pa 1177.se")
                                .font(.system(size: 13, weight: .semibold))

                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 10, weight: .semibold))
                        }
                        .foregroundStyle(gradient)
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
        }
    }
}

// MARK: - BVC Schedule View

struct BVCScheduleView: View {
    private let scheduleItems: [BVCScheduleItem] = [
        BVCScheduleItem(
            age: "1-2 veckor",
            title: "Hembesok",
            description: "Barnmorska/BVC-skoterska besoker hemma. Vikt, langd, huvudomfang. Amningstod.",
            isVaccination: false,
            checklist: ["Vikt och langd", "Huvudomfang", "Amningstod och radgivning", "Navelkontroll"]
        ),
        BVCScheduleItem(
            age: "2-4 veckor",
            title: "Forsta besoket pa BVC",
            description: "PKU-prov om ej tagit. Horselscreening.",
            isVaccination: false,
            checklist: ["PKU-prov (om ej taget)", "Horselscreening (OAE)", "Tillvaxtkontroll", "Foraldrars maende"]
        ),
        BVCScheduleItem(
            age: "6-8 veckor",
            title: "Lakarundersokning",
            description: "Lakarundersokning. Tillvaxtkontroll. Fragor om amning.",
            isVaccination: false,
            checklist: ["Fullstandig lakarundersokning", "Tillvaxtkontroll", "Amningstod", "Hojtreflex och motorik"]
        ),
        BVCScheduleItem(
            age: "3 manader",
            title: "Vaccination 1",
            description: "Vaccination (DTP-polio-Hib-HepB + Pneumokock). Tillvaxt.",
            isVaccination: true,
            checklist: ["DTP-polio-Hib-HepB dos 1", "Pneumokock dos 1", "Tillvaxtkontroll", "Utvecklingsbedomning"]
        ),
        BVCScheduleItem(
            age: "4 manader",
            title: "Tillvaxtkontroll",
            description: "Tillvaxtkontroll. Utvecklingsbedomning.",
            isVaccination: false,
            checklist: ["Vikt, langd, huvudomfang", "Utvecklingsbedomning", "Kommunikation och kontakt"]
        ),
        BVCScheduleItem(
            age: "5 manader",
            title: "Vaccination 2",
            description: "Vaccination (DTP-polio-Hib-HepB + Pneumokock). Tillvaxt.",
            isVaccination: true,
            checklist: ["DTP-polio-Hib-HepB dos 2", "Pneumokock dos 2", "Tillvaxtkontroll"]
        ),
        BVCScheduleItem(
            age: "6 manader",
            title: "Tillvaxt & matintroduktion",
            description: "Tillvaxt. Matintroduktion diskussion.",
            isVaccination: false,
            checklist: ["Tillvaxtkontroll", "Matintroduktion -- radgivning", "Motorisk utveckling", "Tandborja -- tips"]
        ),
        BVCScheduleItem(
            age: "8 manader",
            title: "Tillvaxt & EPDS",
            description: "Tillvaxt. EPDS-screening (postpartum depression). Utveckling.",
            isVaccination: false,
            checklist: ["Tillvaxtkontroll", "EPDS-screening (postpartum)", "Utvecklingsbedomning", "Sosande och mat"]
        ),
        BVCScheduleItem(
            age: "10 manader",
            title: "Utvecklingsbedomning",
            description: "Tillvaxt. Utvecklingsbedomning.",
            isVaccination: false,
            checklist: ["Tillvaxtkontroll", "Motorisk utveckling", "Spraklig utveckling", "Kontakt och samspel"]
        ),
        BVCScheduleItem(
            age: "12 manader",
            title: "Vaccination 3 & lakarundersokning",
            description: "Vaccination (MPR + Pneumokock). Tillvaxt. Lakarundersokning.",
            isVaccination: true,
            checklist: ["MPR (massling-passjuka-roda hund) dos 1", "Pneumokock dos 3", "Lakarundersokning", "Tillvaxtkontroll"]
        ),
        BVCScheduleItem(
            age: "18 manader",
            title: "Vaccination 4 & sprakscreening",
            description: "Vaccination (DTP-polio-Hib-HepB). Sprakscreening. Tillvaxt.",
            isVaccination: true,
            checklist: ["DTP-polio-Hib-HepB dos 3", "Sprakscreening", "Tillvaxtkontroll", "Utvecklingsbedomning"]
        ),
        BVCScheduleItem(
            age: "2.5 ar",
            title: "Tillvaxt & utveckling",
            description: "Tillvaxt. Utvecklingsbedomning.",
            isVaccination: false,
            checklist: ["Tillvaxtkontroll", "Sprakutveckling", "Motorisk utveckling", "Social utveckling"]
        ),
        BVCScheduleItem(
            age: "3 ar",
            title: "Tillvaxt & synundersokning",
            description: "Tillvaxt. Synundersokning.",
            isVaccination: false,
            checklist: ["Tillvaxtkontroll", "Synundersokning", "Horselkontroll", "Utvecklingsbedomning"]
        ),
        BVCScheduleItem(
            age: "4 ar",
            title: "Utvecklingsbedomning",
            description: "Tillvaxt. Utvecklingsbedomning.",
            isVaccination: false,
            checklist: ["Tillvaxtkontroll", "Sprakundersokning", "Motorisk bedomning", "Social och emotionell utveckling"]
        ),
        BVCScheduleItem(
            age: "5 ar",
            title: "Vaccination 5 & skolmognadsbedomning",
            description: "Vaccination (DTP-polio). Skolmognadsbedomning. Tillvaxt.",
            isVaccination: true,
            checklist: ["DTP-polio dos 4", "Skolmognadsbedomning", "Tillvaxtkontroll", "Syn- och horselkontroll"]
        ),
    ]

    var body: some View {
        ZStack {
            Color.appBg.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Info header
                    infoHeader
                        .padding(.horizontal, DS.s4)
                        .padding(.bottom, DS.s5)

                    // Timeline
                    VStack(spacing: 0) {
                        ForEach(Array(scheduleItems.enumerated()), id: \.element.id) { idx, item in
                            DSTimelineItem(
                                gradient: item.isVaccination ? LinearGradient.orangePink : LinearGradient.blueIndigo,
                                isLast: idx == scheduleItems.count - 1
                            ) {
                                scheduleItemCard(item: item)
                            }
                            .staggerAppear(index: idx)
                        }
                    }
                    .padding(.horizontal, DS.s4)

                    Color.clear.frame(height: 90)
                }
                .padding(.top, DS.s3)
            }
        }
        .navigationTitle("BVC-schema")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(Color.appBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    // MARK: - Info Header

    private var infoHeader: some View {
        GlassCard(gradient: .blueIndigo) {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appBlue)

                    Text("Om BVC-schemat")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appText)
                }

                Text("BVC (Barnavardscentralen) erbjuder gratis halsokontroller for alla barn fran fodel till 6 ars alder. Schemat nedan ar det standardschema som foljs i Sverige. Tider kan variera nagot beroende pa region.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.appTextSec)
                    .lineSpacing(4)

                // Legend
                HStack(spacing: DS.s4) {
                    legendItem(color: .appBlue, label: "Kontroll")
                    legendItem(color: .appOrange, label: "Vaccination")
                }
            }
        }
    }

    private func legendItem(color: Color, label: String) -> some View {
        HStack(spacing: DS.s1) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)

            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color.appTextSec)
        }
    }

    // MARK: - Schedule Item Card

    private func scheduleItemCard(item: BVCScheduleItem) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            // Age badge
            HStack(spacing: DS.s2) {
                Text(item.age)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(item.isVaccination ? Color.appOrange : Color.appBlue)

                if item.isVaccination {
                    HStack(spacing: 4) {
                        Image(systemName: "syringe.fill")
                            .font(.system(size: 9, weight: .semibold))
                        Text("VACCINATION")
                            .font(.system(size: 9, weight: .bold))
                            .tracking(0.5)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.appOrange)
                    .clipShape(Capsule())
                }
            }

            // Title
            Text(item.title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.appText)

            // Description
            Text(item.description)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(Color.appTextSec)
                .lineSpacing(3)

            // Checklist
            if !item.checklist.isEmpty {
                VStack(alignment: .leading, spacing: DS.s1 + 2) {
                    ForEach(item.checklist, id: \.self) { checkItem in
                        HStack(alignment: .top, spacing: DS.s2) {
                            Image(systemName: "circle")
                                .font(.system(size: 8, weight: .medium))
                                .foregroundStyle(item.isVaccination ? Color.appOrange.opacity(0.6) : Color.appBlue.opacity(0.6))
                                .padding(.top, 4)

                            Text(checkItem)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                        }
                    }
                }
                .padding(DS.s3)
                .background(
                    (item.isVaccination ? Color.appOrange : Color.appBlue).opacity(0.06)
                )
                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
            }
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(
            RoundedRectangle(cornerRadius: DS.radius)
                .stroke(Color.appBorderMed, lineWidth: 1)
        )
    }
}

// MARK: - BVC Schedule Item

private struct BVCScheduleItem: Identifiable {
    let id = UUID()
    let age: String
    let title: String
    let description: String
    let isVaccination: Bool
    let checklist: [String]
}

#Preview {
    ResourcesView()
}
