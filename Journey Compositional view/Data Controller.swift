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
                    Exercise(name: "Warm Up", nodeImage: "node_image_1_1_1", timeRequired: 10, description: "Basic warm-up exercises", isLocked: false),
                    Exercise(name: "Stretching", nodeImage: "node_image_1_1_2", timeRequired: 15, description: "Full body stretching", isLocked: false),
                    Exercise(name: "Core Workout", nodeImage: "node_image_1_1_3", timeRequired: 20, description: "Basic core exercises", isLocked: false),
                    Exercise(name: "Cool Down", nodeImage: "node_image_1_1_4", timeRequired: 10, description: "Cool down routine", isLocked: false)
                ]
            ),
            Day(
                dayNumber: 2,
                exercises: [
                    Exercise(name: "Cardio", nodeImage: "node_image_1_2_1", timeRequired: 15, description: "Basic cardio workout", isLocked: true),
                    Exercise(name: "Upper Body", nodeImage: "node_image_1_2_2", timeRequired: 20, description: "Upper body strength", isLocked: true),
                    Exercise(name: "Lower Body", nodeImage: "node_image_1_2_3", timeRequired: 20, description: "Lower body strength", isLocked: true),
                    Exercise(name: "Flexibility", nodeImage: "node_image_1_2_4", timeRequired: 15, description: "Flexibility training", isLocked: true)
                ]
            ),
            Day(
                dayNumber: 3,
                exercises: [
                    Exercise(name: "HIIT", nodeImage: "node_image_1_3_1", timeRequired: 20, description: "High intensity interval training", isLocked: true),
                    Exercise(name: "Core Power", nodeImage: "node_image_1_3_2", timeRequired: 15, description: "Advanced core workout", isLocked: true),
                    Exercise(name: "Balance", nodeImage: "node_image_1_3_3", timeRequired: 20, description: "Balance training", isLocked: true),
                    Exercise(name: "Meditation", nodeImage: "node_image_1_3_4", timeRequired: 10, description: "Cool down and meditation", isLocked: true)
                ]
            ),
            Day(
                dayNumber: 4,
                exercises: [
                    Exercise(name: "Power Yoga", nodeImage: "node_image_1_4_1", timeRequired: 25, description: "Power yoga session", isLocked: true),
                    Exercise(name: "Strength", nodeImage: "node_image_1_4_2", timeRequired: 20, description: "Full body strength", isLocked: true),
                    Exercise(name: "Endurance", nodeImage: "node_image_1_4_3", timeRequired: 25, description: "Endurance training", isLocked: true),
                    Exercise(name: "Recovery", nodeImage: "node_image_1_4_4", timeRequired: 15, description: "Active recovery", isLocked: true)
                ]
            ),
            Day(
                dayNumber: 5,
                exercises: [
                    Exercise(name: "Mobility", nodeImage: "node_image_1_5_1", timeRequired: 15, description: "Mobility training", isLocked: true),
                    Exercise(name: "Cardio Blast", nodeImage: "node_image_1_5_2", timeRequired: 25, description: "Intense cardio", isLocked: true),
                    Exercise(name: "Core Focus", nodeImage: "node_image_1_5_3", timeRequired: 20, description: "Core strengthening", isLocked: true),
                    Exercise(name: "Stretching", nodeImage: "node_image_1_5_4", timeRequired: 15, description: "Deep stretching", isLocked: true)
                ]
            ),
            Day(
                dayNumber: 6,
                exercises: [
                    Exercise(name: "Plyo Power", nodeImage: "node_image_1_6_1", timeRequired: 25, description: "Plyometric exercises", isLocked: true),
                    Exercise(name: "Strength Plus", nodeImage: "node_image_1_6_2", timeRequired: 25, description: "Advanced strength", isLocked: true),
                    Exercise(name: "Cardio Mix", nodeImage: "node_image_1_6_3", timeRequired: 20, description: "Mixed cardio workout", isLocked: true),
                    Exercise(name: "Cool Down", nodeImage: "node_image_1_6_4", timeRequired: 15, description: "Recovery and stretching", isLocked: true)
                ]
            ),
            Day(
                dayNumber: 7,
                exercises: [
                    Exercise(name: "Final Push", nodeImage: "node_image_1_7_1", timeRequired: 30, description: "Challenge workout", isLocked: true),
                    Exercise(name: "Power Finish", nodeImage: "node_image_1_7_2", timeRequired: 25, description: "Strength finale", isLocked: true),
                    Exercise(name: "Endurance Max", nodeImage: "node_image_1_7_3", timeRequired: 25, description: "Maximum endurance", isLocked: true),
                    Exercise(name: "Complete Rest", nodeImage: "node_image_1_7_4", timeRequired: 15, description: "Full recovery", isLocked: true)
                ]
            )
        ]
    )

//    let level2 = Level(
//        levelNumber: 2,
//        days: [
//            Day(
//                dayNumber: 1,
//                exercises: [
//                    Exercise(name: "Exercise 1", nodeImage: "node_image_2_1_1"),
//                    Exercise(name: "Exercise 2", nodeImage: "node_image_2_1_2"),
//                    Exercise(name: "Exercise 3", nodeImage: "node_image_2_1_3"),
//                    Exercise(name: "Exercise 4", nodeImage: "node_image_2_1_4")
//                ]
//            ),
//            Day(
//                dayNumber: 2,
//                exercises: [
//                    Exercise(name: "Exercise 1", nodeImage: "node_image_2_2_1"),
//                    Exercise(name: "Exercise 2", nodeImage: "node_image_2_2_2"),
//                    Exercise(name: "Exercise 3", nodeImage: "node_image_2_2_3"),
//                    Exercise(name: "Exercise 4", nodeImage: "node_image_2_2_4")
//                ]
//            ),
//            Day(
//                dayNumber: 3,
//                exercises: [
//                    Exercise(name: "Exercise 1", nodeImage: "node_image_2_3_1"),
//                    Exercise(name: "Exercise 2", nodeImage: "node_image_2_3_2"),
//                    Exercise(name: "Exercise 3", nodeImage: "node_image_2_3_3"),
//                    Exercise(name: "Exercise 4", nodeImage: "node_image_2_3_4")
//                ]
//            )
//        ]
//    )

    let levels = [level1] // Add more levels here if needed

    return Journey(levels: levels)
}

