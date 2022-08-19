//
//  UIImage+Extensions.swift
//  TurismoRacing
//
//  Created by S2 on 12.08.22.
//

import Foundation
import UIKit

extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
