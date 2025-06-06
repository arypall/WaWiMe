//
//  WaWiMiApp.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/1/25.
//

import SwiftUI

@main
struct WaWiMiApp: App {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView() // or your TabView
            } else {
                OnboardingView()
            }
        }
    }
}
