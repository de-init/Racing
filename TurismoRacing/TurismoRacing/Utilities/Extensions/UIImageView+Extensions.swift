//
//  UIImageView+Extensions.swift
//  TurismoRacing
//
//  Created by S2 on 27.09.22.
//

import Foundation
import UIKit

extension UIImageView {
    static func loadImage(image: String, size: CGSize) -> UIImageView {
        let image = UIImage(named: image)
        
        let scaledSize = size
        let render = UIGraphicsImageRenderer(size: scaledSize)
        let scaledImage = render.image { done in
            image?.draw(in: CGRect(origin: .zero, size: scaledSize))
        }
        let imageView = UIImageView(image: scaledImage)
        return imageView
    }
}
