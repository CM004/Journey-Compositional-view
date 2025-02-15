//
//  JourneyModel.swift
//  Journey Compositional View
//
//  Created by Batch - 2 on 21/01/25.
//

import Foundation

// MARK: - Data Model

struct Exercise {
    let name: String
    let nodeImage: String
    let timeRequired: Int
    let description: String
    let isLocked: Bool
}

struct Day {
    let dayNumber: Int
    let exercises: [Exercise]
}

struct Level {
    let levelNumber: Int
    let days: [Day]
}

struct Journey {
    let levels: [Level]
}

