//
//  PaymentVC.swift
//  Fitness
//
//  Created by Namrata Akash on 14/10/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import iOSDropDown
import FCAlertView

class PaymentVC: UIViewController, FCAlertViewDelegate {
    @IBOutlet weak var dropDown : DropDown!
    @IBOutlet weak var dropDown1 : DropDown!
    @IBOutlet weak var dropDown2 : DropDown!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

                selection()
     
    }
        func selection()
        {
            dropDown2.optionArray = ["Paytm", "Credit/Debit Card", "Paypal"]

            dropDown2.didSelect{(selectedText , index ,id) in
                self.dropDown2.text = "\(selectedText)"
            }
            dropDown.optionArray = ["Fitness card", "Student card", "2 months free"]
            dropDown.optionIds = [0,1,2]
            dropDown.didSelect{(selectedText , index ,id) in
                self.dropDown.text = "\(selectedText)"
            }
            if (dropDown.selectedIndex == 0)
            {
                dropDown1.optionArray = ["Golden card", "Silver card", "Platinum card"]
            }
            else if (dropDown.selectedIndex == 1)
                {
                dropDown1.optionArray = ["group","Collage student","15-18 years"]
            }
            else
            {
                dropDown1.optionArray = ["luck draw","more tahn 1 year","2 year"]
            }
            dropDown1.didSelect{(selectedText , index ,id) in
                self.dropDown1.text = "\(selectedText)"
        }
        }
    
    @IBAction func nextbtn(_ sender: Any) {
        if dropDown.text != "" && dropDown1.text != "" && dropDown1.text != ""
        {
            commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "card")
        }
        
        else
        {
            self.alertviewperform(ainview: self, awithTitle: "Enter Details", awithsubtitle: "fill all three details carefully", awithCustomImage: (UIImage(named: "smiley"))!, awithDoneButtonTitle: "OK", aandButtons: nil, aid: 101)
        }
    }
    @IBAction func bkbutton(_ sender: Any) {
        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "membertype")
    }
    func alertviewperform(ainview : UIViewController,awithTitle:String,awithsubtitle:String,awithCustomImage:UIImage, awithDoneButtonTitle:String,aandButtons: [Any]?,aid:Int)  {
        let alert = FCAlertView()
        alert.delegate = self
        alert.showAlert(inView: self,
                        withTitle: awithTitle,
                        withSubtitle: awithsubtitle,
                        withCustomImage:awithCustomImage,
                        withDoneButtonTitle:awithDoneButtonTitle,
                        andButtons:nil)
        alert.cornerRadius = 10
        alert.colorScheme = UIColor.init(displayP3Red: 150, green: 150, blue: 150, alpha:0.0)
        alert.colorScheme = alert.flatBlue
        
    }
}
    

    
