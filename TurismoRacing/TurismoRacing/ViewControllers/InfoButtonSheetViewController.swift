//
//  InfoButtonSheetViewController.swift
//  TurismoRacing
//
//  Created by S2 on 14.08.22.
//

import UIKit

class InfoButtonSheetViewController: UIViewController {
    
    let infoView = InfoView()
    
    override func loadView() {
        self.view = infoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
