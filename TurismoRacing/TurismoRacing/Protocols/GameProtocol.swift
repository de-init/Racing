//
//  GameProtocol.swift
//  TurismoRacing
//
//  Created by S2 on 5.10.22.
//

import Foundation
import UIKit

protocol GameProtocol {
    var currentScore: Int { get set }
    var gameSpeed: TimeInterval { get }
}

class Game: GameProtocol {
    var currentScore: Int = 0
    var gameSpeed: TimeInterval = {
        var difficulty = UserDefaultsManager.shared.getSettings().difficulty
        var time: TimeInterval!
        switch difficulty {
        case .normal:
            time = 4.5
        case .medium:
            time = 4
        case .hard:
            time = 3.2
        }
        return time
    }()
}
