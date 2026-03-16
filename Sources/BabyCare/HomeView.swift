import SwiftUI
import SwiftData

// MARK: - Home View

struct HomeView: View {
    @Binding var selectedTab: Int
    @Environment(\.modelContext) private var modelContext
    @Query private var userData: [UserData]
    @Query(sort: \Appointment.date) private var appointments: [Appointment]

    @State private var showAddFeeding = false
    @State private var showAddJournal = false
    @State private var showAddAppointment = false
    @State private var hasAppeared = false

    private var user: UserData? { userData.first }

    private var upcomingAppointments: [Appointment] {
        appointments.filter { $0.date >= Date() }.prefix(3).map { $0 }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        greetingSection
                            .staggerAppear(index: 0)

                        statusCard
                            .staggerAppear(index: 1)

                        quickActionsSection
                            .staggerAppear(index: 2)

                        if !upcomingAppointments.isEmpty {
                            upcomingSection
                                .staggerAppear(index: 3)
                        }

                        // Bottom padding for tab bar
                        Color.clear.frame(height: 90)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s2)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { navToolbar }
        }
        .sheet(isPresented: $showAddFeeding)     { AddFeedingSheet() }
        .sheet(isPresented: $showAddJournal)     { AddJournalSheet() }
        .sheet(isPresented: $showAddAppointment) { AddAppointmentSheet() }
    }

    // MARK: - Greeting

    @ViewBuilder
    private var greetingSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: DS.s1) {
                Text(greetingText)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.appTextSec)

                Text(user?.name.isEmpty == false ? user!.name : "BabyCare")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
            }

            Spacer()

            // Date chip
            VStack(alignment: .trailing, spacing: 2) {
                Text(Date().formatted(.dateTime.weekday(.wide)))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.appPink)
                    .textCase(.uppercase)
                    .tracking(0.6)

                Text(Date().formatted(.dateTime.day().month(.abbreviated)))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.appText)
            }
            .padding(.horizontal, DS.s3)
            .padding(.vertical, DS.s2)
            .background(Color.appSurface)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
        }
    }

    private var greetingText: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<5:  return "Good night"
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default:     return "Good evening"
        }
    }

    // MARK: - Status Card

    @ViewBuilder
    private var statusCard: some View {
        if let user {
            if user.isPregnant, let dueDate = user.dueDate {
                PregnancyHeroCard(dueDate: dueDate)
            } else if let birthDate = user.babyBirthDate {
                BabyAgeHeroCard(birthDate: birthDate, babyName: user.babyName)
            } else {
                noProfileHeroCard
            }
        } else {
            noProfileHeroCard
        }
    }

    private var noProfileHeroCard: some View {
        Button { selectedTab = 4 } label: {
            GradientCard(gradient: .pinkPurple) {
                HStack(spacing: DS.s4) {
                    Image(systemName: "person.badge.plus")
                        .font(.system(size: 36, weight: .medium))
                        .foregroundStyle(.white)

                    VStack(alignment: .leading, spacing: DS.s1) {
                        Text("Set Up Your Profile")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                        Text("Tap to get started with BabyCare")
                            .font(.system(size: 13))
                            .foregroundStyle(.white.opacity(0.75))
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

    // MARK: - Quick Actions

    private var quickActionsSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Quick Add")

            HStack(spacing: DS.s3) {
                QuickActionTile(
                    title: "Feeding",
                    icon: "drop.fill",
                    gradient: .orangePink
                ) { showAddFeeding = true }

                QuickActionTile(
                    title: "Journal",
                    icon: "note.text",
                    gradient: .blueIndigo
                ) { showAddJournal = true }

                QuickActionTile(
                    title: "Appointment",
                    icon: "calendar.badge.plus",
                    gradient: .greenTeal
                ) { showAddAppointment = true }

                QuickActionTile(
                    title: "Baby Stats",
                    icon: "chart.line.uptrend.xyaxis",
                    gradient: .tealMint
                ) { selectedTab = 2 }
            }
        }
    }

    // MARK: - Upcoming Appointments

    private var upcomingSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Upcoming", action: "See All") { selectedTab = 1 }

            VStack(spacing: DS.s2) {
                ForEach(Array(upcomingAppointments.enumerated()), id: \.element.id) { idx, appt in
                    AppointmentRow(appointment: appt)
                        .staggerAppear(index: idx + 4)
                }
            }
        }
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var navToolbar: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Image(systemName: "heart.fill")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(LinearGradient.pinkPurple)
        }
    }
}

// MARK: - Pregnancy Hero Card

struct PregnancyHeroCard: View {
    let dueDate: Date
    @State private var appeared = false

    private var weeksPregnant: Int {
        let start = Calendar.current.date(byAdding: .weekOfYear, value: -40, to: dueDate) ?? dueDate
        let w = Calendar.current.dateComponents([.weekOfYear], from: start, to: Date()).weekOfYear ?? 0
        return max(0, min(w, 40))
    }
    private var weeksLeft: Int { max(0, 40 - weeksPregnant) }
    private var progress: Double { Double(weeksPregnant) / 40.0 }

    private var trimester: String {
        switch weeksPregnant {
        case 0..<13:  return "1st Trimester"
        case 13..<27: return "2nd Trimester"
        default:      return "3rd Trimester"
        }
    }

    var body: some View {
        GradientCard(gradient: .pinkPurple) {
            HStack(spacing: DS.s5) {
                // Circular progress ring
                ZStack {
                    CircularProgressRing(
                        progress: appeared ? progress : 0,
                        lineWidth: 8,
                        gradient: .pinkPurple
                    )

                    VStack(spacing: 0) {
                        Text("\(weeksPregnant)")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        Text("wks")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }
                .frame(width: 90, height: 90)
                .onAppear {
                    withAnimation(.spring(response: 1.0, dampingFraction: 0.8).delay(0.2)) {
                        appeared = true
                    }
                }

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("Pregnancy")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.6))
                        .textCase(.uppercase)
                        .tracking(0.6)

                    Text(trimester)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    HStack(spacing: DS.s1) {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 11))
                        Text("\(weeksLeft) weeks left")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundStyle(.white.opacity(0.7))

                    HStack(spacing: DS.s1) {
                        Image(systemName: "calendar")
                            .font(.system(size: 11))
                        Text(dueDate.formatted(.dateTime.day().month(.abbreviated).year()))
                            .font(.system(size: 12, weight: .medium))
                    }
                    .foregroundStyle(.white.opacity(0.55))
                }

                Spacer()
            }
        }
    }
}

// MARK: - Baby Age Hero Card

struct BabyAgeHeroCard: View {
    let birthDate: Date
    let babyName: String?

    private var ageComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .weekOfYear], from: birthDate, to: Date())
    }

    private var ageText: String {
        let months = (ageComponents.year ?? 0) * 12 + (ageComponents.month ?? 0)
        if months >= 24 { return "\(months / 12)" }
        if months > 0   { return "\(months)" }
        return "\(ageComponents.weekOfYear ?? 0)"
    }

    private var ageUnit: String {
        let months = (ageComponents.year ?? 0) * 12 + (ageComponents.month ?? 0)
        if months >= 24 { let y = months / 12; return y == 1 ? "year" : "years" }
        if months > 0   { return months == 1 ? "month" : "months" }
        let w = ageComponents.weekOfYear ?? 0
        return w == 1 ? "week" : "weeks"
    }

    var body: some View {
        GradientCard(gradient: .blueIndigo) {
            HStack(spacing: DS.s5) {
                // Age display
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 90, height: 90)

                    VStack(spacing: 0) {
                        Text(ageText)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        Text(ageUnit)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("Your Baby")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.6))
                        .textCase(.uppercase)
                        .tracking(0.6)

                    Text(babyName ?? "Baby's Age")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    HStack(spacing: DS.s1) {
                        Image(systemName: "gift.fill")
                            .font(.system(size: 11))
                        Text(birthDate.formatted(.dateTime.day().month(.abbreviated).year()))
                            .font(.system(size: 12, weight: .medium))
                    }
                    .foregroundStyle(.white.opacity(0.6))
                }

                Spacer()
            }
        }
    }
}

// MARK: - Quick Action Tile

struct QuickActionTile: View {
    let title: String
    let icon: String
    let gradient: LinearGradient
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: DS.s2) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 52, height: 52)
                    .background(gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                Text(title)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, DS.s3)
            .background(Color.appSurface)
            .clipShape(RoundedRectangle(cornerRadius: DS.radius))
            .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Appointment Row (shared across views)

struct AppointmentRow: View {
    let appointment: Appointment

    private var typeGradient: LinearGradient {
        switch appointment.type {
        case .prenatal:    return .pinkPurple
        case .ultrasound:  return .blueIndigo
        case .diabetesTest: return LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .groupBStrep: return .orangePink
        case .pediatric:   return .greenTeal
        case .vaccination: return .tealMint
        case .other:       return LinearGradient(colors: [.appTextSec, .appTextTert], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    var body: some View {
        GlassCard {
            HStack(spacing: DS.s3) {
                IconBadge(icon: appointment.type.icon, gradient: typeGradient, size: 40)

                VStack(alignment: .leading, spacing: 3) {
                    Text(appointment.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)
                        .lineLimit(1)

                    Text(appointment.date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).hour().minute()))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.appTextSec)
                }

                Spacer()

                Text(appointment.type.rawValue.components(separatedBy: " ").first ?? "")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(appointment.type.color)
                    .padding(.horizontal, DS.s2)
                    .padding(.vertical, 4)
                    .background(appointment.type.color.opacity(0.12))
                    .clipShape(Capsule())
            }
        }
    }
}

// MARK: - Add Feeding Sheet

struct AddFeedingSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var feedingType: FeedingType = .breastfeeding
    @State private var amount = ""
    @State private var durationMinutes = ""
    @State private var side: FeedingSide = .left
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Log Feeding", onSave: save) {
            VStack(spacing: DS.s5) {
                // Type selector
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYPE")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(FeedingType.allCases, id: \.self) { type in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    feedingType = type
                                }
                            } label: {
                                Text(type.displayName)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(feedingType == type ? .white : Color.appTextSec)
                                    .padding(.horizontal, DS.s3)
                                    .padding(.vertical, DS.s2)
                                    .background(feedingType == type ? LinearGradient.orangePink : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(feedingType == type ? Color.clear : Color.appBorderMed, lineWidth: 1))
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                // Date
                datePickerRow(label: "TIME", selection: $date, components: [.date, .hourAndMinute])

                // Conditional fields
                if feedingType == .breastfeeding {
                    // Side
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("SIDE")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        HStack(spacing: DS.s2) {
                            ForEach(FeedingSide.allCases, id: \.self) { s in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { side = s }
                                } label: {
                                    Text(s.displayName)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(side == s ? .white : Color.appTextSec)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, DS.s2)
                                        .background(side == s ? LinearGradient.orangePink : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                    }

                    DSTextField(title: "Duration (min)", text: $durationMinutes, keyboard: .numberPad)
                } else if feedingType == .bottle {
                    DSTextField(title: "Amount (ml)", text: $amount, keyboard: .decimalPad)
                }
            }
        }
    }

    private func save() {
        let log = FeedingLog(
            date: date,
            type: feedingType,
            amount: Double(amount),
            duration: Double(durationMinutes).map { $0 * 60 },
            side: feedingType == .breastfeeding ? side : nil
        )
        modelContext.insert(log)
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Journal Sheet

struct AddJournalSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var content = ""
    @State private var selectedMood: Mood? = nil
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "New Entry", onSave: save, canSave: !title.isEmpty) {
            VStack(spacing: DS.s5) {
                DSTextField(title: "Title", text: $title)

                datePickerRow(label: "DATE", selection: $date, components: .date)

                // Mood
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("MOOD")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(Mood.allCases, id: \.self) { mood in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedMood = selectedMood == mood ? nil : mood
                                }
                            } label: {
                                VStack(spacing: 4) {
                                    Text(mood.emoji).font(.title3)
                                    Text(mood.rawValue)
                                        .font(.system(size: 9, weight: .medium))
                                        .foregroundStyle(selectedMood == mood ? mood.color : Color.appTextTert)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s2)
                                .background(selectedMood == mood ? mood.color.opacity(0.15) : Color.appSurface2)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radiusSm)
                                        .stroke(selectedMood == mood ? mood.color.opacity(0.5) : Color.appBorder, lineWidth: 1)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                // Content
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("WRITE")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $content)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.appText)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 120)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
                }
            }
        }
    }

    private func save() {
        modelContext.insert(JournalEntry(date: date, title: title, content: content, mood: selectedMood))
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Appointment Sheet

struct AddAppointmentSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var date = Date()
    @State private var type: AppointmentType = .prenatal
    @State private var notes = ""

    var body: some View {
        DSSheet(title: "Add Appointment", onSave: save, canSave: !title.isEmpty) {
            VStack(spacing: DS.s5) {
                DSTextField(title: "Title", text: $title)

                datePickerRow(label: "DATE & TIME", selection: $date, components: [.date, .hourAndMinute])

                // Type
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYPE")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: DS.s2) {
                            ForEach(AppointmentType.allCases, id: \.self) { t in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { type = t }
                                } label: {
                                    HStack(spacing: 6) {
                                        Image(systemName: t.icon)
                                            .font(.system(size: 12, weight: .semibold))
                                        Text(t.rawValue)
                                            .font(.system(size: 12, weight: .semibold))
                                    }
                                    .foregroundStyle(type == t ? .white : Color.appTextSec)
                                    .padding(.horizontal, DS.s3)
                                    .padding(.vertical, DS.s2)
                                    .background(type == t ? t.color.gradient : Color.appSurface2.gradient)
                                    .clipShape(Capsule())
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                        .padding(.vertical, 2)
                    }
                }

                // Notes
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("NOTES (OPTIONAL)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $notes)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.appText)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 80)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
                }
            }
        }
    }

    private func save() {
        modelContext.insert(Appointment(date: date, title: title, notes: notes, type: type))
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - DS Sheet Wrapper

struct DSSheet<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    let onSave: () -> Void
    var canSave: Bool = true
    @ViewBuilder let content: () -> Content

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    content()
                        .padding(.horizontal, DS.s4)
                        .padding(.top, DS.s4)
                        .padding(.bottom, DS.s12)
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { onSave() }
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(canSave ? Color.appPink : Color.appTextTert)
                        .disabled(!canSave)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Date Picker Row Helper

private func datePickerRow(label: String, selection: Binding<Date>, components: DatePickerComponents) -> some View {
    VStack(alignment: .leading, spacing: DS.s2) {
        Text(label)
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(Color.appTextTert)
            .tracking(0.6)

        DatePicker("", selection: selection, displayedComponents: components)
            .datePickerStyle(.compact)
            .labelsHidden()
            .tint(.appPink)
            .padding(DS.s3)
            .background(Color.appSurface2)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
