//
//  ScheduleWalkView.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/1/25.
//

// ScheduleWalkView.swift
import SwiftUI

struct ScheduleWalkView: View {
    let profile: UserProfile

    @Environment(\.dismiss) var dismiss
    @StateObject private var storage = WalkStorage()

    @State private var selectedDate = Date()
    @State private var location = ""
    @State private var selectedPath = ""
    @State private var showConfirmation = false
    @State private var showValidationError = false

    let suggestedPaths: [String: String] = [
        "": "",
        "Palisades Park Loop": "Start at the rose garden entrance. Flat, ocean view, benches every 200 feet. ~20 mins.",
        "Beachfront Path": "Begin at lifeguard tower 10. Flat, wide walkway with ocean breeze. ~15–25 mins.",
        "Neighborhood Loop": "Begin at 4th & Idaho. Quiet, shaded sidewalks with curb ramps. ~10–15 mins.",
        "Local Park Trail": "Start near community center. Slight incline with trees and benches. ~20 mins."
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Schedule a Walk with \(profile.name)")
                .font(.title2)
                .padding(.top)

            Image(profile.photo)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .shadow(radius: 10)

            VStack(alignment: .leading) {
                Text("Choose Date & Time")
                    .font(.headline)

                DatePicker("Walk Time", selection: $selectedDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()
            }

            VStack(alignment: .leading) {
                Text("Location")
                    .font(.headline)

                TextField("Enter location", text: $location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(location.isEmpty && showValidationError ? Color.red : Color.clear, lineWidth: 1)
                    )
            }

            VStack(alignment: .leading) {
                Text("Suggested Path (Optional)")
                    .font(.headline)

                Picker("Choose a path", selection: $selectedPath) {
                    ForEach(suggestedPaths.keys.sorted(), id: \.self) { path in
                        Text(path.isEmpty ? "None selected" : path)
                    }
                }
                .pickerStyle(.menu)
            }

            Button(action: {
                if location.isEmpty || selectedDate < Date() {
                    showValidationError = true
                } else {
                    let newWalk = ScheduledWalk(
                        name: profile.name,
                        date: selectedDate,
                        location: location,
                        path: selectedPath.isEmpty ? nil : selectedPath,
                        pathDescription: suggestedPaths[selectedPath]
                    )
                    storage.add(walk: newWalk)
                    showConfirmation = true
                    showValidationError = false
                }
            }) {
                Text("Confirm Walk")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background((location.isEmpty || selectedDate < Date()) ? Color.gray : Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .disabled(location.isEmpty || selectedDate < Date())

            if showValidationError {
                Text("Please fill in all fields with valid info.")
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $showConfirmation) {
            WalkConfirmationView(
                profileName: profile.name,
                walkDate: selectedDate,
                location: location,
                path: selectedPath,
                pathSummary: suggestedPaths[selectedPath],
                onDone: {
                    showConfirmation = false
                    dismiss()
                }
            )
        }
    }
}
