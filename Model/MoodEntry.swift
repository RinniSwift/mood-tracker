//
//  Extensions.swift
//  moodTracker
//
//  Created by Rinni Swift on 11/8/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

struct MoodEntry {
    var mood: Mood
    var date: Date
    
    enum Mood: Int {
        case none
        case amazing
        case good
        case neutral
        case bad
        case terrible
        
        var stringValue: String {
            switch self {
            case .none:
                return ""
            case .amazing:
                return "Amazing"
            case .good:
                return "Good"
            case .neutral:
                return "Neutral"
            case .bad:
                return "Bad"
            case .terrible:
                return "Terrible"
            }
        }
        
        var colorValue: UIColor {
            switch self {
            case .none:
                return .clear
            case .amazing:
                return .green
            case .good:
                return .blue
            case.neutral:
                return .gray
            case .bad:
                return .orange
            case .terrible:
                return .red
            }
        }
        
    }
    
}

