//
//  EditWalkView.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/5/25.
//

import SwiftUI

struct EditWalkView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var storage: WalkStorage
    var walkIndex: Int

    @State private var newDate: Date
    @State private var newLocation: String

    init(storage: WalkStorage, walkIndex: Int) {
        self.storage = storage
        self.walkIndex = walkIndex

        let walk = storage.walks[walkIndex]
        _newDate = State(initialValue: walk.date)
        _newLocation = State(initialValue: walk.location)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Edit Walk with \(storage.walks[walkIndex].name)")
                .font(.title2)

            DatePicker("Walk Time", selection: $newDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()

            TextField("Location", text: $newLocation)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Save Changes") {
                storage.walks[walkIndex].date = newDate
                storage.walks[walkIndex].location = newLocation
                dismiss()
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}

