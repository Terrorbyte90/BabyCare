import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userData: [UserData]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header with welcome message
                if let user = userData.first {
                    Text(user.isPregnant ? "Welcome back, expecting parent!" : "Welcome back, parent!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Display pregnancy progress or baby age
                    if user.isPregnant, let dueDate = user.dueDate {
                        PregnancyProgressCard(dueDate: dueDate)
                    } else if let birthDate = user.babyBirthDate {
                        BabyAgeCard(birthDate: birthDate)
                    }
                } else {
                    Text("Set up your profile to get started")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                
                // Quick actions
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        QuickActionCard(title: "Add Feeding", icon: "fork.knife", color: .orange) {
                            // Action would navigate to feeding log
                        }
                        QuickActionCard(title: "New Journal", icon: "note.text", color: .blue) {
                            // Action would navigate to new journal entry
                        }
                        QuickActionCard(title: "Appointment", icon: "calendar.badge.plus", color: .green) {
                            // Action would navigate to add appointment
                        }
                        QuickActionCard(title: "Baby Stats", icon: "figure.child", color: .purple) {
                            // Action would navigate to baby measurements
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addSampleData) {
                        Label("Sample", systemImage: "plus.circle")
                    }
                }
            }
        }
    }
    
    private func addSampleData() {
        // For preview/sample purposes
        let user = UserData(isPregnant: true, dueDate: Date().addingTimeInterval(30*24*3600)) // 30 weeks from now
        modelContext.insert(user)
        
        // Add a sample pregnancy week
        let week30 = PregnancyWeek(week: 30, title: "Week 30", description: "Your baby is about the size of a cabbage.", tip: "Start counting kicks daily.")
        modelContext.insert(week30)
        
        // Add a sample appointment
        let appointment = Appointment(date: Date().addingTimeInterval(7*24*3600), title: "Prenatal Checkup", notes: "Regular checkup", type: .prenatal)
        modelContext.insert(appointment)
        
        try? modelContext.save()
    }
}

struct PregnancyProgressCard: View {
    let dueDate: Date
    
    private var weeksPregnant: Int {
        let startDate = Date() - 40*7*24*3600 // Assume 40 weeks pregnancy, adjust as needed
        let weeks = Calendar.current.dateComponents([.weekOfYear], from: startDate, to: Date()).weekOfYear ?? 0
        return min(weeks, 40)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pregnancy Progress")
                .font(.headline)
            
            ProgressView(value: Double(weeksPregnant), total: 40)
                .accentColor(.pink)
            
            HStack {
                Text("Week \(weeksPregnant)")
                Spacer()
                Text("\(40 - weeksPregnant) weeks left")
            }
            .font(.subheadline)
            
            Text("Due: \(dueDate, style: .date)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.pink.opacity(0.1)))
        .cornerRadius(15)
    }
}

struct BabyAgeCard: View {
    let birthDate: Date
    
    private var ageInMonths: Int {
        let components = Calendar.current.dateComponents([.month], from: birthDate, to: Date())
        return components.month ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Baby's Age")
                .font(.headline)
            
            HStack {
                Text("\(ageInMonths) months")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "figure.child")
                    .font(.largeTitle)
            }
            
            Text("Born: \(birthDate, style: .date)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.1)))
        .cornerRadius(15)
    }
}

struct QuickActionCard: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(color)
                    .cornerRadius(10)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
            .frame(width: 80)
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [UserData.self, PregnancyWeek.self, Appointment.self], inMemory: true)
}