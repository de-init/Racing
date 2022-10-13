//
//  Images.swift
//  TurismoRacing
//
//  Created by S2 on 8.09.22.
//

import Foundation
import UIKit

struct Objects {
    enum TypeObject: String {
        case barrel = "barrelObject"
        case barrier = "barrierObject"
        case cone = "coneObject"
        case coin = "coinObject"
        case block = "blockObject"
        case bomb = "bombObject"
        case pig = "pigObject"
        case turn = "turnObject"
        case warn = "warnObject"
    }
    
    static let objectArray = [Objects.TypeObject.barrel.rawValue,
                              Objects.TypeObject.barrier.rawValue,
                              Objects.TypeObject.cone.rawValue,
                              Objects.TypeObject.coin.rawValue,
                              Objects.TypeObject.block.rawValue,
                              Objects.TypeObject.bomb.rawValue,
                              Objects.TypeObject.pig.rawValue,
                              Objects.TypeObject.turn.rawValue,
                              Objects.TypeObject.warn.rawValue]
}
