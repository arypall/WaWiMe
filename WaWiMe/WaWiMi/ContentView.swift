//
//  ContentView.swift
//  WaWiMe
//
//  Created by ashley ryf-pallister on 5/1/25.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SwipeView()
                .tabItem {
                    Label("Browse", systemImage: "person.2")
                }

            ScheduleListView()
                .tabItem {
                    Label("My Walks", systemImage: "calendar")
                }
        }
    }
}

