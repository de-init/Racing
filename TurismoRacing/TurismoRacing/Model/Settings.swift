//
//  Settings.swift
//  TurismoRacing
//
//  Created by S2 on 30.09.22.
//

import Foundation


struct Settings: Codable {
    var difficulty: Difficulty = .normal
    var car: Int = 0
}
