//
//  DiscriptionpostVC.swift
//  Fitness
//
//  Created by Namrata Akash on 24/12/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import FCAlertView

class DiscriptionpostVC: UIViewController, postdelegate,FCAlertViewDelegate
{
    
    
    func post_returnresp(ajosondata: [Any]) {
        print("response:\(ajosondata)");
        let aDictTemp  = ajosondata[0] as? [String:String];
        let aStrStatus  = aDictTemp!["status"];

        if aStrStatus  == "Success"
        {
            DispatchQueue.main.async
            {
                self.ShowAlertView(strTitle:"Success", strMsg:"Post Added Sucessfully ...", strDoneBtnTitle:"Ok", aIntTag:101);
            }
            print("LOG = Post Added Sucessfully ...");
        }
        else
        {
            print("LOG = Failed ...");
        }
    }
    
  
    @IBOutlet weak var descriptiontxt: UITextView!
    @IBOutlet weak var titletxt: UITextField!
    var imagedata = String()
var arrimage = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func callWStopstdata() {
        let ctrlobj = PostController()
        ctrlobj.delegate = self
        var amodelonj = Postmodel(post_id: 1, post_title: titletxt.text!, post_description: descriptiontxt.text!, category: "gym", date_time: Commoncode().Getcurrentdateandtime(), image_list: imagedata, video_list: "N/A", posted_id: Commoncode().getCurrentuserID(),post_favourite: 1,post_like: 2)
        ctrlobj.userPost(aModelObj: amodelonj)
        

    }

    @IBAction func donebutton(_ sender: Any) {
        callWStopstdata()
    }
  
   


    //MARK: - AlertView Methods
    func ShowAlertView(strTitle: String, strMsg: String, strDoneBtnTitle: String, aIntTag:Int)
    {
        let alert = FCAlertView();
        alert.delegate = self;
        alert.tag = aIntTag;
        if(aIntTag == 101)//Send
        {
            alert.makeAlertTypeSuccess();
        }
        else
        {
            alert.makeAlertTypeWarning();
        }
        alert.showAlert(inView: self, withTitle:strTitle, withSubtitle:strMsg, withCustomImage: nil, withDoneButtonTitle: strDoneBtnTitle, andButtons:nil)
    }

    func fcAlertDoneButtonClicked(_ alertView: FCAlertView)
    {
        if(alertView.tag == 101)//Send
        {
            [self.navigationController?.popViewController(animated: true)];
        }
        else//Error
        {
        }
    }
    
    
}
