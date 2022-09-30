//
//  GameManager.swift
//  TurismoRacing
//
//  Created by S2 on 27.09.22.
//

import Foundation
import UIKit

class GameManager: GameViewController {
    static let shared = GameManager()
    
    func loadMap() -> [UIImageView] {
        let mapArray = [UIImageView.loadImage(image: Maps.Desert.firstImage.name, size: view.bounds.size),
                        UIImageView.loadImage(image: Maps.Desert.secondImage.name, size: view.bounds.size),
                        UIImageView.loadImage(image: Maps.Desert.thirdImage.name, size: view.bounds.size)]
        return mapArray
    }
}
