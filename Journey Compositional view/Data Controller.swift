//
//  JourneyManager.swift
//  Journey Compositional View
//
//  Created by Batch - 2 on 21/01/25.
//

import Foundation

final class JourneyManager {
    private init() {
        self.journey = generateJourney()
    }
    
    static let shared = JourneyManager()
    private let journey: Journey
    
    func getJourney() -> Journey {
        return journey
    }
}

private func generateJourney() -> Journey {
    let level1 = Level(
        levelNumber: 1,
        days: [
            Day(
                dayNumber: 1,
                exercises: [
                    Exercise(name: "Warm Up", nodeImage: "exerciseImage1", timeRequired: 4, isLocked: false),
                    Exercise(name: "Stretching", nodeImage: "exerciseImage2", timeRequired: 5, isLocked: false),
                    Exercise(name: "Core Workout", nodeImage: "exerciseImage3", timeRequired: 6, isLocked: false),
                    Exercise(name: "Cool Down", nodeImage: "exerciseImage4", timeRequired: 4, isLocked: false)
                ]
            ),
            Day(
                dayNumber: 2,
                exercises: [
                    Exercise(name: "Cardio", nodeImage: "exerciseImage1", timeRequired: 4, isLocked: true),
                    Exercise(name: "Upper Body", nodeImage: "exerciseImage2", timeRequired: 5, isLocked: true),
                    Exercise(name: "Lower Body", nodeImage: "exerciseImage3", timeRequired: 6, isLocked: true),
                    Exercise(name: "Flexibility", nodeImage: "exerciseImage4", timeRequired: 4, isLocked: true)
                ]
            ),
            Day(
                dayNumber: 3,
                exercises: [
                    Exercise(name: "HIIT", nodeImage: "exerciseImage1", timeRequired: 4, isLocked: true),
                    Exercise(name: "Core Power", nodeImage: "exerciseImage2", timeRequired: 5, isLocked: true),
                    Exercise(name: "Balance", nodeImage: "exerciseImage3", timeRequired: 6, isLocked: true),
                    Exercise(name: "Meditation", nodeImage: "exerciseImage4", timeRequired: 4, isLocked: true)
                ]
            ),
            Day(
                dayNumber: 4,
                exercises: [
                    Exercise(name: "Power Yoga", nodeImage: "exerciseImage1", timeRequired: 4, isLocked: true),
                    Exercise(name: "Strength", nodeImage: "exerciseImage2", timeRequired: 5, isLocked: true),
                    Exercise(name: "Endurance", nodeImage: "exerciseImage3", timeRequired: 6, isLocked: true),
                    Exercise(name: "Recovery", nodeImage: "exerciseImage4", timeRequired: 4, isLocked: true)
                ]
            ),
            Day(
                dayNumber: 5,
                exercises: [
                    Exercise(name: "Mobility", nodeImage: "exerciseImage1", timeRequired: 4, isLocked: true),
                    Exercise(name: "Cardio Blast", nodeImage: "exerciseImage2", timeRequired: 5, isLocked: true),
                    Exercise(name: "Core Focus", nodeImage: "exerciseImage3", timeRequired: 6, isLocked: true),
                    Exercise(name: "Stretching", nodeImage: "exerciseImage4", timeRequired: 4, isLocked: true)
                ]
            ),
            Day(
                dayNumber: 6,
                exercises: [
                    Exercise(name: "Plyo Power", nodeImage: "exerciseImage1", timeRequired: 4, isLocked: true),
                    Exercise(name: "Strength Plus", nodeImage: "exerciseImage2", timeRequired: 5, isLocked: true),
                    Exercise(name: "Cardio Mix", nodeImage: "exerciseImage3", timeRequired: 6, isLocked: true),
                    Exercise(name: "Cool Down", nodeImage: "exerciseImage4", timeRequired: 4, isLocked: true)
                ]
            ),
            Day(
                dayNumber: 7,
                exercises: [
                    Exercise(name: "Final Push", nodeImage: "exerciseImage1", timeRequired: 4, isLocked: true),
                    Exercise(name: "Power Finish", nodeImage: "exerciseImage2", timeRequired: 5, isLocked: true),
                    Exercise(name: "Endurance Max", nodeImage: "exerciseImage3", timeRequired: 6, isLocked: true),
                    Exercise(name: "Complete Rest", nodeImage: "exerciseImage4", timeRequired: 4, isLocked: true)
                ]
            )
        ]
    )

    let levels = [level1]
    return Journey(levels: levels)
}
