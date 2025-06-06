//
//  ScheduledWalk.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 6/3/25.
//

import Foundation

struct ScheduledWalk: Identifiable, Codable {
    var id = UUID()
    let name: String
    var date: Date
    var location: String
    var path: String?
    var pathDescription: String?
}

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

    func save() {
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
