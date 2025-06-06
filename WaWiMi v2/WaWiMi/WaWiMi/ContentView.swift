//
//  ContentView.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var age = ""
    @State private var walkTime = "Morning"
    @State private var isReady = false

    let walkTimes = ["Morning", "Afternoon", "Evening"]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to WaWiMi")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                TextField("Your Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                TextField("Your Age", text: $age)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Picker("Preferred Walk Time", selection: $walkTime) {
                    ForEach(walkTimes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Button(action: {
                    if !name.isEmpty && !age.isEmpty {
                        isReady = true
                    }
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()
            }

.fullScreenCover(isPresented: $isReady) {
                SwipeView(name: name, age: age, walkTime: walkTime)
            }
        }
    }
}
