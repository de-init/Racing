//
//  InfoButtonSheetViewController.swift
//  TurismoRacing
//
//  Created by S2 on 14.08.22.
//

import UIKit

class InfoButtonSheetViewController: UIViewController {
    
    private let infoView = InfoView()
    
    override func loadView() {
        self.view = infoView
    }
}
