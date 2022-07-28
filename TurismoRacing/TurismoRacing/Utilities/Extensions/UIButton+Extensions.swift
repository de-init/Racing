//
//  UIButton+Extensions.swift
//  TurismoRacing
//
//  Created by S2 on 27.07.22.
//

import Foundation
import UIKit

extension UIButton {
    func setBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
