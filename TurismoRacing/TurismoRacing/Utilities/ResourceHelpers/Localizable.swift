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
    case pauseText = "pause_menu_text"
    case playText = "play_text"
    case exitText = "exit_text"
    case totalScore = "total_score"
    case recordScore = "record_score"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
