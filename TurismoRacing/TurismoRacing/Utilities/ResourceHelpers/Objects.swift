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
        case barrel = "ic_barrel"
        case barrier = "ic_barrier"
        case cone = "ic_cone"
        case coin = "ic_coin"
        case block = "ic_block"
        case bomb = "ic_bomb"
        case pig = "ic_pig"
        case turn = "ic_turn"
        case warn = "ic_warn"
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
