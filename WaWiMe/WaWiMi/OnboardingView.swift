//
//  OnboardingView.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/5/25.
//

import SwiftUI

struct OnboardingView: View {
    let pages: [OnboardingPage] = [
        OnboardingPage(title: "Welcome to WaWiMi", subtitle: "Meet friendly walk partners near you.", imageName: "figure.walk.circle"),
        OnboardingPage(title: "Swipe to Connect", subtitle: "Like someone? Swipe right to match!", imageName: "hand.tap"),
        OnboardingPage(title: "Schedule Your Walk", subtitle: "Pick a time, location, and get walking.", imageName: "calendar.badge.clock")
    ]

    @State private var currentPage = 0
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false

    var body: some View {
        VStack {
            Spacer()

            Image(systemName: pages[currentPage].imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding()

            Text(pages[currentPage].title)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 5)

            Text(pages[currentPage].subtitle)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.gray)

            Spacer()

            if currentPage == pages.count - 1 {
                Button("Get Started") {
                    hasSeenOnboarding = true
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
                .padding(.horizontal)
            } else {
                Button("Next") {
                    currentPage += 1
                }
                .padding()
            }

            Spacer()
        }
        .padding()
        .animation(.easeInOut, value: currentPage)
    }
}

