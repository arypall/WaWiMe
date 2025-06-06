//
//  WalkStorage.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/5/25.
//
import Foundation

class WalkStorage: ObservableObject {
    @Published var walks: [ScheduledWalk] = []

    private let key = "scheduled_walks"

    init() {
        load()
    }

    func add(walk: ScheduledWalk) {
        walks.append(walk)
        save()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(walks) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([ScheduledWalk].self, from: data) {
            walks = decoded
        }
    }
}


