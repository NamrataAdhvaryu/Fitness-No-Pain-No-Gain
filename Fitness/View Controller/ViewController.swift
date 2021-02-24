//
//  ViewController.swift
//  Fitness
//
//  Created by Namrata Akash on 26/08/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var imgview1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       assignbackground()
        view2.backgroundColor = #colorLiteral(red: 0.3024283051, green: 0.7529703975, blue: 0.8169582486, alpha: 1).withAlphaComponent(0.5)
        view3.backgroundColor = #colorLiteral(red: 0.3024283051, green: 0.7529703975, blue: 0.8169582486, alpha: 1).withAlphaComponent(0.5)
        view4.backgroundColor = #colorLiteral(red: 0.3024283051, green: 0.7529703975, blue: 0.8169582486, alpha: 1).withAlphaComponent(0.5)
        view5.backgroundColor = #colorLiteral(red: 0.3024283051, green: 0.7529703975, blue: 0.8169582486, alpha: 1).withAlphaComponent(0.5)
        imgview1.backgroundColor = #colorLiteral(red: 0.3024283051, green: 0.7529703975, blue: 0.8169582486, alpha: 1).withAlphaComponent(0.5)
    }
    func assignbackground(){
        let background = UIImage(named: "f1")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        
        
        
    }


}

