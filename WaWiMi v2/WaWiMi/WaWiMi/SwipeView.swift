//
//  SwipeView.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/1/25.
//

import SwiftUI

struct UserProfile: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let bio: String
    let photo: String
}

struct SwipeView: View {
    let name: String
    let age: String
    let walkTime: String

    @State private var profiles = [
        UserProfile(name: "Harriet", age: 66, bio: "Walks daily near Palisades Park", photo: "harriet_photo"),
        UserProfile(name: "George", age: 70, bio: "Enjoys afternoon coastal strolls", photo: "george_photo"),
        UserProfile(name: "Elaine", age: 63, bio: "Loves chatting and slow walks", photo: "elaine_photo")
    ]

    var body: some View {
        VStack {
            Text("Hi \(name) 👋")
                .font(.title2)
                .padding(.top)

            Text("Finding walk buddies for \(walkTime.lowercased()) walks...")
                .font(.subheadline)
                .padding(.bottom)

            Spacer()

            if let profile = profiles.first {
                SwipeCardView(profile: profile) { removedProfile in
                    profiles.removeAll { $0.id == removedProfile.id }
                }
            } else {
                Text("No more walk buddies nearby.")
                    .font(.headline)
            }

            Spacer()
        }
        .padding()
    }
}

struct SwipeCardView: View {
    let profile: UserProfile
    var onRemove: (_ profile: UserProfile) -> Void

    @State private var offset = CGSize.zero
    @GestureState private var isDragging = false

    var body: some View {
        ZStack {
            if UIImage(named: profile.photo) != nil {
                Image(profile.photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 280, height: 320)
                    .clipped()
                    .cornerRadius(20)
                    .shadow(radius: 8)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 280, height: 320)
                    .cornerRadius(20)
                    .overlay(Text("Image Not Found").foregroundColor(.white))
            }

            VStack {
                Spacer()
                VStack(spacing: 8) {
                    Text("\(profile.name), \(profile.age)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Text(profile.bio)
                        .font(.body)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
            }
            .padding()
        }
        .offset(x: offset.width)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .gesture(
            DragGesture()
                .updating($isDragging) { _, _, _ in }
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { gesture in
                    if abs(gesture.translation.width) > 100 {
                        onRemove(profile)
                    } else {
                        offset = .zero
                    }
                }
        )
        .animation(.spring(), value: offset)
    }
}
import SwiftUI

struct UserProfile: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let bio: String
    let photo: String
}

struct SwipeView: View {
    let name: String
    let age: String
    let walkTime: String

    @State private var profiles = [
        UserProfile(name: "Ashlee", age: 66, bio: "Walks daily near Palisades Park", photo: "Ashlee_photo"),
        UserProfile(name: "Ashley", age: 70, bio: "Enjoys afternoon coastal strolls", photo: "Ashley_photo"),
        UserProfile(name: "Ash", age: 63, bio: "Loves chatting and slow walks", photo: "Ash_photo")
    ]

    var body: some View {
        VStack {
            Text("Hi \(name) 👋")
                .font(.title2)
                .padding(.top)

            Text("Finding walk buddies for \(walkTime.lowercased()) walks...")
                .font(.subheadline)
                .padding(.bottom)

            Spacer()

            if let profile = profiles.first {
                SwipeCardView(profile: profile) { removedProfile in
                    profiles.removeAll { $0.id == removedProfile.id }
                }
            } else {
                Text("No more walk buddies nearby.")
                    .font(.headline)
            }

            Spacer()
        }
        .padding()
    }
}

struct SwipeCardView: View {
    let profile: UserProfile
    var onRemove: (_ profile: UserProfile) -> Void

    @State private var offset = CGSize.zero
    @GestureState private var isDragging = false

    var body: some View {
        ZStack {
            if UIImage(named: profile.photo) != nil {
                Image(profile.photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 280, height: 320)
                    .clipped()
                    .cornerRadius(20)
                    .shadow(radius: 8)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 280, height: 320)
                    .cornerRadius(20)
                    .overlay(Text("Image Not Found").foregroundColor(.white))
            }

            VStack {
                Spacer()
                VStack(spacing: 8) {
                    Text("\(profile.name), \(profile.age)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Text(profile.bio)
                        .font(.body)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
            }
            .padding()
        }
        .offset(x: offset.width)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .gesture(
            DragGesture()
                .updating($isDragging) { _, _, _ in }
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { gesture in
                    if abs(gesture.translation.width) > 100 {
                        onRemove(profile)
                    } else {
                        offset = .zero
                    }
                }
        )
        .animation(.spring(), value: offset)
    }
}
