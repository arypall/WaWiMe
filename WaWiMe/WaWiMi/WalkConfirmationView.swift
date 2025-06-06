//
//  WalkConfirmationView.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/5/25.
//
import SwiftUI

struct WalkConfirmationView: View {
    let profileName: String
    let walkDate: Date
    let location: String
    let path: String?
    let pathSummary: String?
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("You're All Set!")
                .font(.largeTitle)
                .bold()
                .padding(.top)

            Text("You have a walk scheduled with \(profileName).")
                .font(.title3)
                .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("🕒 Date & Time:")
                        .bold()
                    Spacer()
                    Text(walkDate.formatted(date: .abbreviated, time: .shortened))
                }

                HStack {
                    Text("📍 Location:")
                        .bold()
                    Spacer()
                    Text(location)
                }

                if let path = path, let summary = pathSummary {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("🗺️ Suggested Path:")
                            .bold()
                        Text(path)
                        Text(summary)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)

            Spacer()

            Button("Done") {
                onDone()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

