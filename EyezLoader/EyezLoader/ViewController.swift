//
//  ViewController.swift
//  EyezLoader
//
//  Created by Parth Adroja on 3/5/16.
//  Copyright © 2016 Parth Adroja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var IBloadingEyez: EyeSpinView!
    override func viewDidLoad() {
        super.viewDidLoad()
        IBloadingEyez.addSpinAnimation()
        
        
        let loadView = EyeSpinView(frame: CGRectMake(100,100,30,30))
        loadView.color = UIColor.orangeColor()
        self.view.addSubview(loadView)
        loadView.addSpinAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

