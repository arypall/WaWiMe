//
//  ScheduleListView.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/5/25.
//
import SwiftUI

struct ScheduleListView: View {
    @StateObject private var storage = WalkStorage()
    @State private var selectedIndex: Int?
    @State private var showingEditSheet = false

    var body: some View {
        NavigationView {
            if storage.walks.isEmpty {
                VStack {
                    Spacer()
                    Text("No walks yet 🙂")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .navigationTitle("Scheduled Walks")
            } else {
                List {
                    ForEach(Array(storage.walks.enumerated()), id: \.offset) { index, walk in
                        VStack(alignment: .leading) {
                            Text(walk.name)
                                .font(.headline)
                            Text(walk.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.subheadline)
                            Text("Location: \(walk.location)")
                                .font(.subheadline)
                            if let path = walk.path, !path.isEmpty {
                                Text("Path: \(path)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .onTapGesture {
                            selectedIndex = index
                            showingEditSheet = true
                        }
                    }
                    .onDelete { indices in
                        indices.forEach { index in
                            storage.walks.remove(at: index)
                        }
                        storage.save()
                    }
                }
                .navigationTitle("Scheduled Walks")
                .navigationBarItems(trailing: EditButton())
                .sheet(isPresented: $showingEditSheet) {
                    if let index = selectedIndex {
                        // Comment this out if you haven’t implemented EditWalkView yet
                        EditWalkView(storage: storage, walkIndex: index)
                    }
                }
            }
        }
    }
}
