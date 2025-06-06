//
//  SwipeView.swift
//  WaWiMe
//
//  Created by ashley ryf-pallister on 5/1/25.
//

import SwiftUI

struct SwipeView: View {
    @State private var profiles = [
        UserProfile(name: "Harriet", age: 66, bio: "Walks daily near Palisades Park", photo: "harriet_photo"),
        UserProfile(name: "George", age: 70, bio: "Enjoys afternoon coastal strolls", photo: "george_photo"),
        UserProfile(name: "Elaine", age: 63, bio: "Loves chatting and slow walks", photo: "elaine_photo")
    ]

    @State private var selectedProfile: UserProfile?
    @State private var showSchedule = false
    @State private var showLikedOverlay = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if let profile = profiles.first {
                        SwipeCardView(profile: profile, onLike: { likedProfile in
                            selectedProfile = likedProfile
                            showLikedOverlay = true

                            // Delay showing schedule to allow animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                showLikedOverlay = false
                                showSchedule = true
                            }
                        })
                    } else {
                        Text("No more profiles nearby.")
                            .font(.headline)
                            .padding()
                    }
                }

                if showLikedOverlay {
                    VStack {
                        Text("⭐️ Liked!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .transition(.scale)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                }
            }
            .fullScreenCover(isPresented: $showSchedule) {
                if let profile = selectedProfile {
                    ScheduleWalkView(profile: profile)
                }
            }
            .navigationTitle("Find a Walk Partner")
        }
    }
}
