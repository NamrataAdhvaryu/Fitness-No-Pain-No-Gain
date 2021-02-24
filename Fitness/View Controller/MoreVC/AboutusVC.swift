//
//  AboutusVC.swift
//  Fitness
//
//  Created by Namrata Akash on 02/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class AboutusVC: UIViewController {

    @IBOutlet weak var aboutview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func aboutusbkbtn(_ sender: Any) {
        commomcodeobj.pushVCwithoutanimate(acurrentvc: self, nextvcidentifier: "MoreVC")
    }
    
    
}
