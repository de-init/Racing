//
//  Fonts.swift
//  TurismoRacing
//
//  Created by S2 on 5.08.22.
//

import Foundation
import UIKit

protocol FontName {
    var fontName: String { get }
}

struct Fonts {
    enum Poppins: String, FontName {
        case extraLight = "-ExtraLight"
        case semiBold = "-SemiBold"
        case bold = "-Bold"
        var fontName: String {
            return "Poppins\(rawValue)"
        }
    }
    
    enum HammersmithOne: String, FontName {
        case regular = "-Regular"
        var fontName: String {
            return "HammersmithOne\(rawValue)"
        }
    }
    
    enum OrelegaOne: String, FontName {
        case regular = "-Regular"
        var fontName: String {
            return "OrelegaOne\(rawValue)"
        }
    }
    enum Montserrat: String, FontName {
        case regular = "-Regular"
        case medium = "-Medium"
        var fontName: String {
            return "MontserratRoman\(rawValue)"
        }
    }
}
