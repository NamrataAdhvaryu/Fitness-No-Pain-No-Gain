//
//  ViewProfileVC.swift
//  Fitness
//
//  Created by Namrata Akash on 30/10/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import MDatePickerView
var INT_TABLE_FIELD_TAG = 100
class ViewProfileVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,MDatePickerViewDelegate,userprofileDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    
    
    @IBOutlet weak var tbl:UITableView!
    var HEIGHT_FOR_HEADER_TITLE = 50
    var arrfortitle = [Any]()
    var dicforresponse = [String:String]()
    var dictfortextfield = [String:Any]()
    var imgprofile = UIImage()
    var imgcover = UIImage()
    var intforgender = 0
    var strDOB = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrfortitle = ["Profile pic","Personal","Contacts","Location","Other","Done"]
        dictfortextfield = ["Personal":["User Name","Display Name","Gender","DOB"],"Contacts":["Email","Contact no"],"Location":["Area","City","Country"],"Other":["Class Time","About Us"]]
        
        if commomcodeobj.CheckPlistFileIsExistOrNotAsPerFileName(aStrPlistName: Constant().USER_PROFILE_PLIST)
        {
            dicforresponse = Commoncode().readPlist(aStrPlistNameRef: Constant().USER_PROFILE_PLIST)
            print("dictForResponse: \(dicforresponse)");
        }
        else{
            callWStogetprofiledata()
            
        }
        let astrimgdata = dicforresponse["user_profile_img"]
        if (astrimgdata != "")
        {
            imgprofile = UIImage(data: commomcodeobj.Displayimgfromserver(url: Constant().BASE_URL, Images: astrimgdata!))!
        }
        let astrcover = dicforresponse["user_cover_img"]
        if (astrcover != "")
        {
            imgcover = UIImage(data: commomcodeobj.Displayimgfromserver(url: Constant().BASE_URL, Images: astrcover!))!
        }
        intforgender = Int(dicforresponse["gender"]!) ?? 0
        print("intgorgender:\(intforgender)")
        strDOB = dicforresponse["dob"]!
        
        
        
    }
    @objc func genderbuttonclick(_ sender:Any)
    {
        intforgender = (sender as! AnyObject).tag
        print("intgender:\(intforgender)")
        tbl.reloadData()
        
    }
    @objc func pickYourImage(_ sender:UITapGestureRecognizer? = nil)
    
    {
        let apicker = UIImagePickerController()
        apicker.delegate = self
        
        apicker.sourceType = .photoLibrary
        apicker.view.tag = sender?.view?.tag as! Int
        present(apicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if (picker.view.tag == 11)
        {
            imgcover = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        }
        else
        {
            imgprofile = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        }
        dismiss(animated: true)
        {
            self.tbl.reloadData()
        }
    }
    @objc func savebtnclicked()  {
     callWStoupdateprofiledata()
    }
   //table view methods starts
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrfortitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0)
        {
            return 1
        }
        else if(section == 1)
        {
            return 4
        }
        else if(section == 2)
        {
            return 2
        }
        else if(section == 3)
        {
            return 3
        }
        else if(section == 4)
        {
            return 2
        }
        
        else
        {
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.section == 0)
        {
            return 270;
        }
        else if(indexPath.section == 1)
        {
            if(indexPath.row == 2 || indexPath.row == 3)
            {
                return 70;
            }
            else
            {
                return 85;
            }
        }
        else if(indexPath.section == 5)
        {
            return 60;
        }
        else
        {
            return 85;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
{
        if (indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfilePicCell", for: indexPath) as! ProfilePicCell
            let tapgestureprofilepic  = UITapGestureRecognizer(target: self, action: #selector(self.pickYourImage(_:)))
            tapgestureprofilepic.numberOfTapsRequired = 1
            
            cell.profilepic.addGestureRecognizer(tapgestureprofilepic)
            cell.profilepic.isUserInteractionEnabled = true
            cell.profilepic.CreateRoundImageView(aFloatWidth: 120)

            if (imgprofile.size.width != 0)
            {
                cell.profilepic.image = imgprofile
            }
            else
            {
                cell.profilepic.image = UIImage(named: "akash1")
            }
            let strcovertapgesture = UITapGestureRecognizer(target: self, action: #selector(self.pickYourImage(_:)))
            strcovertapgesture.numberOfTapsRequired = 1
            strcovertapgesture.numberOfTouchesRequired = 1
            
            cell.coverpic.addGestureRecognizer(strcovertapgesture)
            cell.coverpic.isUserInteractionEnabled = true
            if(imgcover.size.width != 0)
            {
                cell.coverpic.image = imgcover
            }
            else
            {
                cell.coverpic.image = UIImage(named: "akash2")
            }
            cell.profilepic.tag = 10
            cell.coverpic.tag = 11
            return cell
        }
else if(indexPath.section == 1)
{
           var strdickeyname = "Personal"
            
            let arrfortitle = dictfortextfield[strdickeyname] as! [String]
            
            if (indexPath.row == 2) //gender
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "GenderCell", for: indexPath) as! GenderCell
                cell.lblgender.text = arrfortitle[indexPath.row]
                cell.btnmale.CreateRoundButton(aCornerRadius: 30)
                cell.btnfemale.CreateRoundButton(aCornerRadius: 30)
                cell.btnother.CreateRoundButton(aCornerRadius: 30)
                if(intforgender == 1) //male
                    {
                    cell.btnfemale.CreateRoundSelectedButton(aCornerRadius: 30)
                    }
                else if (intforgender == 2) //female
                    {
                    cell.btnmale.CreateRoundSelectedButton(aCornerRadius: 30)
                     }
                
                else //other
                    {
                    cell.btnother.CreateRoundSelectedButton(aCornerRadius: 30)
                   }
            
                cell.btnmale.addTarget(self, action: #selector(genderbuttonclick(_:)), for: .touchUpInside)
                cell.btnfemale.addTarget(self, action: #selector(genderbuttonclick(_:)), for: .touchUpInside)
                cell.btnother.addTarget(self, action: #selector(genderbuttonclick(_:)), for: .touchUpInside)
                cell.btnfemale.tag = 1
                cell.btnmale.tag = 2
                cell.btnother.tag = 3
                return cell
         }
            else if(indexPath.row == 3) //dob
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DobCell", for: indexPath) as! DobCell
                cell.lbldb.text = arrfortitle[indexPath.row]
                cell.lblvalue.text = strDOB
                cell.calenderbtn.CreateRoundButton(aCornerRadius: 30)
                cell.lblvalue.tag = (INT_TABLE_FIELD_TAG * indexPath.section) + indexPath.row
                cell.calenderbtn.addTarget(self, action: #selector(ShowCalender), for: .touchUpInside)
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextfieldCell", for: indexPath) as! TextfieldCell
                cell.lblname.text = arrfortitle[indexPath.row]
                cell.txtvalue.text = txtvalue(indexpath:indexPath)
                cell.txtvalue.tag = (INT_TABLE_FIELD_TAG * indexPath.section) + indexPath.row
                cell.txtvalue.textColor = .white
                return cell
            }
}
else if(indexPath.section == 5)
{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
                cell.savebtn.addTarget(self, action: #selector(savebtnclicked), for: .touchUpInside)
    cell.savebtn.tag = (INT_TABLE_FIELD_TAG * indexPath.section) + indexPath.row
    cell.savebtn.CreateRoundButton(aCornerRadius: 30)
    cell.savebtn.backgroundColor = Constant().COLOUR_APP_THEME_PRIMARY
    cell.savebtn.setTitle("Save", for: .normal)
    cell.savebtn.titleLabel?.textColor = .white
    
                return cell
}
else
{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextfieldCell", for: indexPath) as! TextfieldCell
    var strdickeyname = "Other"
    if (indexPath.section == 2)
    {
        strdickeyname = "Contacts"
    }
    else if (indexPath.section == 3)
    {
        strdickeyname = "Location"
    }
   let arrfortitle = dictfortextfield[strdickeyname] as! [String]
    cell.lblname.text = arrfortitle[indexPath.row] as! String
    cell.txtvalue.text = txtvalue(indexpath: indexPath)
    cell.txtvalue.textColor = .white
    cell.txtvalue.tag = (INT_TABLE_FIELD_TAG * indexPath.section) + indexPath.row
    return cell

}

    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0 || section == 5)
        {
            return 0
        }
        else
        {
            return CGFloat(HEIGHT_FOR_HEADER_TITLE)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0 || section == 5)
        {
            return nil;
        }
        else
        {
            let aLblFrame = CGRect(x: 10, y: 0, width: tableView.frame.size.width - 20, height: CGFloat(HEIGHT_FOR_HEADER_TITLE));
            let aLblHeaderTitle = UILabel(frame:aLblFrame);
            aLblHeaderTitle.font = Constant().FONT_TBL_HEADER_TITLE;
            aLblHeaderTitle.text = (arrfortitle[section] as! String);
            aLblHeaderTitle.textColor = Constant().COLOR_APP_THEME_TEXT_MAIN_TITLE;
            
            let aViewFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: CGFloat(HEIGHT_FOR_HEADER_TITLE));
            let aViewHeaderObj = UIView(frame:aViewFrame);
            aViewHeaderObj.backgroundColor = UIColor.clear;
            aViewHeaderObj.addSubview(aLblHeaderTitle);
            
            return aViewHeaderObj;
        }
    }
    //table view method ends
    func callWStogetprofiledata()
    {
        let ctrl = UserProfileController()
        ctrl.delegate = self
        let amodel = profilemodel(profile_id: Commoncode().getCurrentuserID())
        ctrl.getUserProfile(amodel: amodel)
        
    }
    func getUserData_returnesp(arrresp:[Any])
    {
       print("arrresp:\(arrresp)")
        if (arrresp.count > 0)
        {
            print("record get sucessfully.........")
            dicforresponse = arrresp[0] as! [String:String]
            Commoncode().createplist(aStrPlistNameRef: Constant().USER_PROFILE_PLIST, dic: dicforresponse)
            tbl.reloadData()
        }
        else
        {
            print("something went wrong")
        }
    }
    func updateUserProfile_returnresp(arrresp:[Any])
    {
        print("arrrrsp:\(arrresp)")

            let adic = arrresp[0] as! [String:String]
        let astatus = adic["status"] as! String
        if astatus == "Success"
        {
            print("updated sucessfully......")
            
            DispatchQueue.main.async {
                if Commoncode().CheckPlistFileIsExistOrNotAsPerFileName(aStrPlistName: Constant().USER_PROFILE_PLIST)
            {
//                Commoncode().removePlist(aStrPlistNameRef: Constant().USER_PROFILE_PLIST)
            }
                
            }
            
            
        
        }
    }
    func callWStoupdateprofiledata()
    {
        let ctrl = UserProfileController()
    ctrl.delegate = self
        var aimgprofilestr = ""
        if(imgprofile.size.width != 0)
        {
            aimgprofilestr = commomcodeobj.createimgbase64(aimg: imgprofile)
            
        }
        var aimgcoverstr = ""
        if(imgcover.size.width != 0)
        {
            aimgcoverstr = commomcodeobj.createimgbase64(aimg: imgcover)
        }
        let amodel = profilemodel(profile_id: Commoncode().getCurrentuserID(),
                                  name: dicforresponse["name"]!,
                                  display_name: dicforresponse["display_name"]!,
                                  gender: dicforresponse["gender"]!,
                                  dob: dicforresponse["dob"]!,
                                  mail: dicforresponse["email"]!,
                                  mobile_no: dicforresponse["mobile_no"]!,
                                  area: dicforresponse["area"]!,
                                  city: dicforresponse["city"]!,
                                  country: dicforresponse["country"]!,
                                  about_us: dicforresponse["about_us"]!,
                                  batch_detail: dicforresponse["batch_detail"]!,
                                  user_profile_img: aimgprofilestr,
                                  user_cover_img: aimgcoverstr)
        ctrl.updateUserProfile(amodel: amodel)
    }
    //textfiels methods
    func txtvalue(indexpath:IndexPath) -> String
    {
        var astrvalue = " "
        
        do {
            if (dicforresponse.keys.count > 0)
            {
                if (indexpath.section == 1)
                {
                    if (indexpath.row == 0) //personal
                    {

                        astrvalue = dicforresponse["name"]!
                        }
                    else if (indexpath.row == 1)
                    {
                        astrvalue = dicforresponse["display_name"]!
                    }
                    
                }
                else if (indexpath.section == 2)
                {
                    if (indexpath.row == 0) //personal
                    {

                        astrvalue = dicforresponse["email"]!
                        }
                    else if (indexpath.row == 1)
                    {
                        astrvalue = dicforresponse["mobile_no"]!
                    }
                }
                else if(indexpath.section == 3)
                {
                    if (indexpath.row == 0)
                    {

                        astrvalue = dicforresponse["area"]!
                        }
                    else if (indexpath.row == 1)
                    {
                        astrvalue = dicforresponse["city"]!
                    }
                   
                    else if (indexpath.row == 2)
                    {
                        astrvalue = dicforresponse["country"]!
                    }
                    
                }
                else if (indexpath.section == 4)
                {
                    if (indexpath.row == 0)
                    {

                        astrvalue = dicforresponse["batch_detail"]!
                        }
                    else if (indexpath.row == 1)
                    {
                        astrvalue = dicforresponse["about_us"]!
                    }
                }
               }
        }
        return astrvalue
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
       var  aStrValue = textField.text!;
       if(dicforresponse.keys.count > 0)
       {
           if(textField.tag == 100)//User Name
           {
        dicforresponse = ["user_name":aStrValue];
           }
           else if(textField.tag == 101) // displayname
           {
            dicforresponse = ["display_name":aStrValue]
           }
           else if(textField.tag == 103) //gender
           {
            dicforresponse = ["dob":aStrValue] //dob
           }
           else if(textField.tag == 200) // email
           {
            dicforresponse = ["email":aStrValue]
           }
           else if(textField.tag == 201) //contact no
           {
            dicforresponse = ["mobile_no":aStrValue]
           }
           else if(textField.tag == 300) //area
           {
            dicforresponse = ["area":aStrValue]
           }
           else if(textField.tag == 301) //city
           {
            dicforresponse = ["city":aStrValue]
           }
           else if(textField.tag == 302) //country
           {
            dicforresponse = ["country":aStrValue]
           }
           else if(textField.tag == 400) //class time
           {
            dicforresponse = ["batch_detail":aStrValue]
           }
           else if(textField.tag == 401) //about us
           {
            dicforresponse = ["about_us":aStrValue]
           }
        
        
       }
    }
    //calender methods
    @objc func ShowCalender()
    {
        view.addSubview(MDate)
        NSLayoutConstraint.activate([
            MDate.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            MDate.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            MDate.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            MDate.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        
        view.addSubview(Today)
        Today.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        Today.topAnchor.constraint(equalTo: MDate.bottomAnchor, constant: 20).isActive = true
        
        view.addSubview(Label)
        Label.topAnchor.constraint(equalTo: Today.bottomAnchor, constant: 30).isActive = true
        Label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func HideCalender()
    {
        MDate.removeFromSuperview();
        Label.removeFromSuperview();
        Today.removeFromSuperview();
    }
    
    lazy var MDate : MDatePickerView = {
        let mdate = MDatePickerView()
        mdate.delegate = self
        mdate.Color = Constant().COLOUR_APP_THEME_PRIMARY;
        mdate.cornerRadius = 14
        mdate.translatesAutoresizingMaskIntoConstraints = false
        mdate.from = 1920
        mdate.to = 2050
        return mdate
    }()
    
    let Today : UIButton = {
        let but = UIButton(type:.system)
        but.setTitle("    Done    ", for: .normal)
        but.addTarget(self, action: #selector(done), for: .touchUpInside)
        but.translatesAutoresizingMaskIntoConstraints = false
        
        
        but.setTitleColor(UIColor.green, for: .normal);
        but.backgroundColor = UIColor.white;
        but.titleLabel?.font = UIFont.systemFont(ofSize: 30);
        but.backgroundColor = Constant().COLOUR_APP_THEME_PRIMARY;
        but.layer.cornerRadius = 25;// but.frame.size.height / 2;
        but.setTitleColor(.white, for: .normal);
        
        return but
    }()
    
    let Label : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func done()
    {
        HideCalender();
    }
    
    @objc func today()
    {
        //You can get current date using this function
        MDate.selectDate = Date()
    }
    
    func mdatePickerView(selectDate: Date)
    {
        print("selected date 1: \(selectDate)");
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: selectDate)
        strDOB = date;
        print("strDOB : \(strDOB)");
//        Label.text = date
        tbl.reloadData();
        
    }
    
}
