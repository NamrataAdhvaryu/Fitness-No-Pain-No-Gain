//
//  CreditcardVC.swift
//  Fitness
//
//  Created by Namrata Akash on 14/10/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import MFCard
import FCAlertView

class CreditcardVC: UIViewController,MFCardDelegate,FCAlertViewDelegate {
    func cardDoneButtonClicked(_ card: Card?, error: String?) {
        if error == nil{
            self.alertviewperform(ainview: self, awithTitle: "Success", awithsubtitle: "Payment done", awithCustomImage:(UIImage(named: "smiley"))! , awithDoneButtonTitle: "OK", aandButtons: nil,aid: 101)

        } else {
            self.alertviewperform(ainview: self, awithTitle: "Fail", awithsubtitle: "Something went wrong", awithCustomImage:(UIImage(named: "sad"))! , awithDoneButtonTitle: "OK", aandButtons: nil,aid: 100)
        
        }
    }
    
    func cardTypeDidIdentify(_ cardType: String) {
        
    }
    
    func cardDidClose() {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var myCard : MFCardView
        myCard  = MFCardView(withViewController: self)
        myCard.delegate = self
        myCard.autoDismiss = true
        myCard.toast = true
        
        myCard.frontChromeColor = .black
        
        
        myCard.showCard()
    }
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        if (alertView.title == "Success")
        {
            commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "payment")
        }
        else
        {
            print("try again")
        }
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

    @IBAction func bkbtn(_ sender: Any) {
        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "payment")
    }
}
