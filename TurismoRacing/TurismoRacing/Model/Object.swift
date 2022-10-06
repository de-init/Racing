//
//  Object.swift
//  TurismoRacing
//
//  Created by S2 on 5.10.22.
//

import Foundation
import UIKit

class Object: UIImageView {
    
    private let skins = Objects.objectArray
    
    private var currentSkin: String {
        let skin = Int.random(in: 0...skins.count-1)
        return skins[skin]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFit
        self.image = UIImage(named: currentSkin)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    static func generateObject(objectSize: CGSize, objectPoints: [CGPoint]) -> [Object] {
        let points = objectPoints.shuffled().suffix(Int.random(in: 1...2))
        var objects: [Object] = []
        for point in points {
            objects.append(Object.init(frame: CGRect(x: point.x, y: point.y, width: objectSize.width - 4, height: objectSize.height)))
        }
        return objects
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
