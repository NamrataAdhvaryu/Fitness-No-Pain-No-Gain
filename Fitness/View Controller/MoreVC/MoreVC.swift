//
//  MoreVC.swift
//  Fitness
//
//  Created by Namrata Akash on 10/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import FCAlertView
import StoreKit
import MessageUI
import Messages

class MoreVC: UIViewController,UITableViewDelegate,UITableViewDataSource,FCAlertViewDelegate,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tableviewmore: UITableView!
let Commomcodeobj = Commoncode()
    
    var arrForTitle = ["Change Password",
                          "About Us",
                          "Contact Us",
                          "Rate Us",
                          "Tell Your Friend",
                          "Sign Out"]
    var arrforimg:[UIImage] = [UIImage(named:"passwordmore")!,UIImage(named:"About Us")!,UIImage(named:"About Us")!,UIImage(named:"Rate Us")!,UIImage(named:"tell your friend")!,UIImage(named: "Logout")!]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewmore.delegate = self
        tableviewmore.dataSource = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForTitle.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Morecell
        cell.lblmore.text = arrForTitle[indexPath.row]
        cell.imgmore.image = arrforimg[indexPath.row]
        return cell
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) //changepassword
        {
            Commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "changepwdidentifier")
        }
        else if (indexPath.row == 1) //about us
        {
            Commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "aboutusidentifier")
        }
        else if (indexPath.row == 2) //contact us
        {
            OpenMailForContactUs()
        }
        else if (indexPath.row == 3) // rate us
        {
            SKStoreReviewController.requestReview()

        }
        else if (indexPath.row == 4) // tell your friend
        {
            OpenFileforTellYourFriend()
        }
        else if (indexPath.row == 5)
        {
            let buttons = ["yes","No"]
            DispatchQueue.main.async { [self] in
                alertviewperform(ainview: self, awithTitle: "Sign Out", awithsubtitle: "Are you sure you want to sign out?", awithCustomImage: UIImage(named: "sad")!,aandButtons: buttons, aid: 100)

            }
     
        
    }
    }
    func OpenFileforTellYourFriend()
    {
        let astrmessage = "\(Constant().SHARE_MSG_PART_1)\(Constant().APP_NAME)\(Constant().SHARE_MSG_PART_2)\(Constant().APP_STORE_LINK)"
        print(astrmessage)
        let asrrstrmessageitem = [astrmessage]
        let activtyctrlobj = UIActivityViewController(activityItems: asrrstrmessageitem, applicationActivities: nil)
        activtyctrlobj.excludedActivityTypes = [.postToVimeo,.postToTencentWeibo]
        self.present(activtyctrlobj, animated: true, completion: nil)
    }
    
        func OpenMailForContactUs()
        
        {
            let mail = MFMailComposeViewController()
            let strtitle = "Contact us | \(Constant().APP_NAME)"
            let strrecipants = ["namrata.adhvaryu05@gmail.com"]
            let srtmessage = ""
            mail.setSubject(strtitle)
            mail.setToRecipients(strrecipants)
            mail.setMessageBody(srtmessage, isHTML: false)
            self.present(mail, animated: true, completion: nil)
        }
        
     func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
     {
        switch result {
        case .cancelled:
            print("mail cancelled")
        case .sent:
            print("mail sent")
        case .saved:
            print("mail saved")
        case .failed:
            print("mail failed:\(String(describing:error?.localizedDescription))")
        default:
           break
        }
        dismiss(animated: true, completion: nil)
     }
        
        
  func alertviewperform(ainview : UIViewController,awithTitle:String,awithsubtitle:String,awithCustomImage:UIImage,aandButtons: [Any]?,aid:Int)  {
        let alert = FCAlertView()
        
    alert.hideDoneButton = true
        alert.delegate = self
        
        alert.showAlert(inView: self,
                        withTitle: awithTitle,
                        withSubtitle: awithsubtitle,
                        withCustomImage:awithCustomImage,
                        withDoneButtonTitle:nil,
                        andButtons:aandButtons)
        
        alert.cornerRadius = 10
        alert.colorScheme = UIColor.init(displayP3Red: 150, green: 150, blue: 150, alpha:0.0)
        alert.colorScheme = alert.flatBlue
        
    }
       
        

    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!)
       {
           if (index == 0)
           {
            
            commomcodeobj.removePlist(aStrPlistNameRef: Constant().USER_LOGIN_PLIST)
            commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "loginidentifier")
           }
           else if(index == 1)
           {commomcodeobj.removePlist(aStrPlistNameRef: Constant().USER_PROFILE_PLIST)
            commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "loginidentifier")
               
           }
           else
           {
            alertView.dismiss()
           }
           }
}
