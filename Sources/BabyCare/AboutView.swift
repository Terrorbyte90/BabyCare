import SwiftUI

// MARK: - About View

struct AboutView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        // Logo / Hero
                        VStack(spacing: DS.s4) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient.pinkPurple.opacity(0.15))
                                    .frame(width: 120, height: 120)

                                Circle()
                                    .stroke(LinearGradient.pinkPurple, lineWidth: 2)
                                    .frame(width: 110, height: 110)

                                Image(systemName: "heart.fill")
                                    .font(.system(size: 52, weight: .medium))
                                    .foregroundStyle(LinearGradient.pinkPurple)
                            }
                            .shadow(color: Color.appPink.opacity(0.3), radius: 20, y: 8)

                            VStack(spacing: DS.s1 + 2) {
                                Text("BabyCare")
                                    .font(.system(size: 32, weight: .heavy, design: .rounded))
                                    .foregroundStyle(LinearGradient.pinkPurple)

                                Text("Version 1.0")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.appTextTert)
                            }
                        }
                        .padding(.top, DS.s6)
                        .staggerAppear(index: 0)

                        // Description Card
                        GlassCard {
                            VStack(alignment: .leading, spacing: DS.s3) {
                                HStack(spacing: DS.s2) {
                                    Image(systemName: "sparkles")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(LinearGradient.pinkPurple)
                                    Text("Om appen")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(Color.appText)
                                }

                                Text("BabyCare är skapad med kärlek för att stödja föräldrar och gravida genom en av livets mest magiska resor. Från de första veckorna av graviditet till barnets femte år — vi finns här.")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color.appTextSec)
                                    .lineSpacing(5)
                            }
                        }
                        .staggerAppear(index: 1)

                        // Privacy Card
                        GlassCard {
                            VStack(alignment: .leading, spacing: DS.s3) {
                                HStack(spacing: DS.s2) {
                                    Image(systemName: "shield.checkered")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(LinearGradient.greenTeal)
                                    Text("Integritetspolicy")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(Color.appText)
                                }

                                Text("All din data lagras lokalt på din enhet. Vi samlar aldrig in, säljer eller delar din personliga information. Du har full kontroll över dina uppgifter.")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color.appTextSec)
                                    .lineSpacing(5)

                                HStack(spacing: DS.s2) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color.appGreen)
                                    Text("Ingen molnlagring")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundStyle(Color.appText)
                                }

                                HStack(spacing: DS.s2) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color.appGreen)
                                    Text("Ingen spårning")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundStyle(Color.appText)
                                }

                                HStack(spacing: DS.s2) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color.appGreen)
                                    Text("Ingen annonsering")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundStyle(Color.appText)
                                }
                            }
                        }
                        .staggerAppear(index: 2)

                        // Creator Card
                        GlassCard {
                            VStack(alignment: .leading, spacing: DS.s3) {
                                HStack(spacing: DS.s2) {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(LinearGradient.blueIndigo)
                                    Text("Skapare")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(Color.appText)
                                }

                                HStack(spacing: DS.s3) {
                                    ZStack {
                                        Circle()
                                            .fill(LinearGradient.blueIndigo.opacity(0.15))
                                            .frame(width: 52, height: 52)
                                        Text("T")
                                            .font(.system(size: 22, weight: .heavy, design: .rounded))
                                            .foregroundStyle(LinearGradient.blueIndigo)
                                    }

                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Ted Svärd")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(Color.appText)
                                        Text("iOS-utvecklare & pappa")
                                            .font(.system(size: 13, weight: .medium))
                                            .foregroundStyle(Color.appTextSec)
                                    }

                                    Spacer()
                                }
                            }
                        }
                        .staggerAppear(index: 3)

                        // Feedback Card
                        GlassCard {
                            VStack(alignment: .leading, spacing: DS.s3) {
                                HStack(spacing: DS.s2) {
                                    Image(systemName: "envelope.fill")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(LinearGradient.orangePink)
                                    Text("Feedback & kontakt")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(Color.appText)
                                }

                                Text("Har du synpunkter, idéer eller hittat en bugg? Vi vill höra från dig!")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color.appTextSec)
                                    .lineSpacing(4)

                                if let url = URL(string: "mailto:hej@babycare.app") {
                                    Link(destination: url) {
                                        HStack(spacing: DS.s2) {
                                            Image(systemName: "envelope.badge.fill")
                                                .font(.system(size: 14, weight: .semibold))
                                            Text("Skicka feedback")
                                                .font(.system(size: 14, weight: .semibold))
                                        }
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, DS.s3)
                                        .background(LinearGradient.orangePink)
                                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                    }
                                }
                            }
                        }
                        .staggerAppear(index: 4)

                        // Tech info
                        Text("Byggd med SwiftUI & SwiftData\nFungerar helt offline")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appTextTert)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .staggerAppear(index: 5)

                        Color.clear.frame(height: 90)
                    }
                    .padding(.horizontal, DS.s4)
                }
            }
            .navigationTitle("Om BabyCare")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AboutView()
}
