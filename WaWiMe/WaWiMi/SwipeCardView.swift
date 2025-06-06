//
//  SwipeCardView.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/5/25.
//

import SwiftUI

struct SwipeCardView: View {
    let profile: UserProfile
    var onLike: (_ profile: UserProfile) -> Void

    @State private var offset = CGSize.zero
    @GestureState private var isDragging = false

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Image(profile.photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 220)
                    .clipShape(Circle())
                    .shadow(radius: 8)

                Text("\(profile.name), \(profile.age)")
                    .font(.title)
                    .bold()

                Text(profile.bio)
                    .font(.body)
                    .multilineTextAlignment(.center)

                Button(action: {
                    onLike(profile)
                }) {
                    Image(systemName: "star.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.yellow)
                }

                Text("Tap the star to schedule a walk")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
        .offset(x: offset.width, y: offset.height)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .gesture(
            DragGesture()
                .updating($isDragging) { _, _, _ in }
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { _ in
                    offset = .zero  // snap back instead of removing
                }
        )
        .animation(.spring(), value: offset)
    }
}
