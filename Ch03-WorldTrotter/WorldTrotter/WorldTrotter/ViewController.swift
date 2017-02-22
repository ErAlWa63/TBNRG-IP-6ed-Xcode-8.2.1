//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Erik Waterham on 2/22/17.
//  Copyright © 2017 Erik Waterham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
        let firstView = UIView(frame: firstFrame)
        firstView.backgroundColor = UIColor.blue
        view.addSubview(firstView)
    }

}

