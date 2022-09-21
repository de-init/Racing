//
//  Localizable.swift
//  TurismoRacing
//
//  Created by S2 on 5.08.22.
//

import Foundation

enum Strings: String {
    case play = "play_button_title"
    case score = "score_game_title"
    case bestScore = "best_score_title"
    case leaderboard = "leaderboard_title"
    case settings = "settings_title"
    case difficulty = "difficulty_title"
    case easy = "easy_mode_title"
    case medium = "medium_mode_title"
    case hard = "hard_mode_title"
    case info = "info_title"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
