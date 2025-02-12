//
//  JourneyManager.swift
//  Journey Compositional View
//
//  Created by Batch - 2 on 21/01/25.
//

import Foundation

// MARK: - Singleton Class

final class JourneyManager {
    // Private initializer to enforce the singleton pattern
    private init() {
        self.journey = generateJourney()
    }
    
    // Static shared instance
    static let shared = JourneyManager()
    
    // Private stored property for journey data
    private let journey: Journey
    
    // Public method to access journey data
    func getJourney() -> Journey {
        return journey
    }
}

// MARK: - Hardcoded Journey Data

private func generateJourney() -> Journey {
    let level1 = Level(
        levelNumber: 1,
        days: [
            Day(
                dayNumber: 1,
                exercises: [
                    Exercise(name: "Exercise 1", nodeImage: "node_image_1_1_1"),
                    Exercise(name: "Exercise 2", nodeImage: "node_image_1_1_2"),
                    Exercise(name: "Exercise 3", nodeImage: "node_image_1_1_3"),
                    Exercise(name: "Exercise 4", nodeImage: "node_image_1_1_4")
                ]
            ),
            Day(
                dayNumber: 2,
                exercises: [
                    Exercise(name: "Exercise 1", nodeImage: "node_image_1_2_1"),
                    Exercise(name: "Exercise 2", nodeImage: "node_image_1_2_2"),
                    Exercise(name: "Exercise 3", nodeImage: "node_image_1_2_3"),
                    Exercise(name: "Exercise 4", nodeImage: "node_image_1_2_4")
                ]
            ),
            Day(
                dayNumber: 3,
                exercises: [
                    Exercise(name: "Exercise 1", nodeImage: "node_image_1_3_1"),
                    Exercise(name: "Exercise 2", nodeImage: "node_image_1_3_2"),
                    Exercise(name: "Exercise 3", nodeImage: "node_image_1_3_3"),
                    Exercise(name: "Exercise 4", nodeImage: "node_image_1_3_4")
                ]
            )
        ]
    )

    let level2 = Level(
        levelNumber: 2,
        days: [
            Day(
                dayNumber: 1,
                exercises: [
                    Exercise(name: "Exercise 1", nodeImage: "node_image_2_1_1"),
                    Exercise(name: "Exercise 2", nodeImage: "node_image_2_1_2"),
                    Exercise(name: "Exercise 3", nodeImage: "node_image_2_1_3"),
                    Exercise(name: "Exercise 4", nodeImage: "node_image_2_1_4")
                ]
            ),
            Day(
                dayNumber: 2,
                exercises: [
                    Exercise(name: "Exercise 1", nodeImage: "node_image_2_2_1"),
                    Exercise(name: "Exercise 2", nodeImage: "node_image_2_2_2"),
                    Exercise(name: "Exercise 3", nodeImage: "node_image_2_2_3"),
                    Exercise(name: "Exercise 4", nodeImage: "node_image_2_2_4")
                ]
            ),
            Day(
                dayNumber: 3,
                exercises: [
                    Exercise(name: "Exercise 1", nodeImage: "node_image_2_3_1"),
                    Exercise(name: "Exercise 2", nodeImage: "node_image_2_3_2"),
                    Exercise(name: "Exercise 3", nodeImage: "node_image_2_3_3"),
                    Exercise(name: "Exercise 4", nodeImage: "node_image_2_3_4")
                ]
            )
        ]
    )

    let levels = [level1, level2] // Add more levels here if needed

    return Journey(levels: levels)
}

