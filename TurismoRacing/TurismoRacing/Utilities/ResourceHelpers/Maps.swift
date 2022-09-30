//
//  Maps.swift
//  TurismoRacing
//
//  Created by S2 on 27.09.22.
//

import Foundation
import UIKit

protocol MapName {
    var name: String { get }
}

struct Maps {
    enum Desert: String, MapName {
        case firstImage = "desertMap1"
        case secondImage = "desertMap2"
        case thirdImage = "desertMap3"
        var name: String {
            return "\(rawValue)"
        }
    }
}
