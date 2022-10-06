//
//  Cars.swift
//  TurismoRacing
//
//  Created by S2 on 27.09.22.
//

import Foundation
import UIKit

struct Cars {
    enum Model: String {
        case defaultModel = "defaultCar"
        case audi = "carAudi"
        case bmw = "carBMW"
        case ferrari = "carFerrari"
        case honda = "carHonda"
        case porsche = "carPorsche"
        case buggati = "carBuggati"
        case dogde = "carDodge"
    }
    
    static let carsArray = [Cars.Model.defaultModel.rawValue,
                            Cars.Model.audi.rawValue,
                            Cars.Model.bmw.rawValue,
                            Cars.Model.ferrari.rawValue,
                            Cars.Model.honda.rawValue,
                            Cars.Model.porsche.rawValue,
                            Cars.Model.buggati.rawValue,
                            Cars.Model.dogde.rawValue]
}
