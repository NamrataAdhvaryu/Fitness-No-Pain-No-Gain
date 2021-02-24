//
//  ProfileVC.swift
//  Fitness
//
//  Created by Namrata Akash on 10/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController,userprofileDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postimage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellobj = collectview.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cellobj.image.image = postimage[indexPath.row]
        return cellobj
        
        
    }
    
 
    
    var postimage:[UIImage] = [UIImage(named: "gymboy1.jpg")!,UIImage(named: "gymboy2.jpg")!,UIImage(named: "gymboy3.jpg")!,UIImage(named: "gymboy4.jpg")!]
    @IBOutlet weak var coverimg: UIImageView!
    
    @IBOutlet weak var countrylbl: UILabel!
    @IBOutlet weak var collectview: UICollectionView!
    @IBOutlet weak var aboutlbl: UILabel!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    
var intprofileref = Int()
var abooleancurrentuser = false
    var dicforresponse = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    override func viewWillAppear(_ animated: Bool) {


        if (intprofileref == 0)
        {
            intprofileref = commomcodeobj.getCurrentuserID()

        }
        if(commomcodeobj.IsProfileIDAndCurrentUserIDAreSame(aIntProfileId: intprofileref))
        {
            abooleancurrentuser = true
            if(commomcodeobj.CheckPlistFileIsExistOrNotAsPerFileName(aStrPlistName: Constant().USER_PROFILE_PLIST))
            {
                dicforresponse = commomcodeobj.readPlist(aStrPlistNameRef: Constant().USER_PROFILE_PLIST)
                print(dicforresponse)
                getUserData()

            }
            else
            {
                callWStogetdata(aprofileidref: Commoncode().getCurrentuserID())
            }
        }
        else
        {
            //This is Other User
            abooleancurrentuser = false;
            callWStogetdata(aprofileidref: intprofileref)
        }

    }

    func getUserData_returnesp(arrresp:[Any])
    {
        print(arrresp)
        if arrresp.count == 1
        {
             dicforresponse = arrresp[0] as! [String:Any]
            Commoncode().createplist(aStrPlistNameRef: Constant().USER_PROFILE_PLIST, dic: dicforresponse)
            getUserData();
  
    }
    }
    func getUserData() {
       
        
        if (dicforresponse.keys.count > 0)
        {
            
        
            namelbl.text = dicforresponse["name"] as! String
            citylbl.text = dicforresponse["city"] as! String
            countrylbl.text = dicforresponse["country"] as! String
        }
        
        if (commomcodeobj.StringIsNotEmpty(aStrVal: aboutlbl.text!) || aboutlbl.text == "")
        {
            aboutlbl.numberOfLines = 0
            aboutlbl.text = "I am active member of \(Constant().APP_NAME)"
        }
       
            
        let strforimagename = dicforresponse["user_profile_img"] as! String

        print(strforimagename);
        if(commomcodeobj.StringIsNotEmpty(aStrVal:strforimagename as! String))
         {


        let aurl1 = Constant().BASE_URL
        print(aurl1)
        let bk = strforimagename
        print(bk)
        profileimg.image = UIImage(data: Commoncode().Displayimgfromserver(url: aurl1, Images: bk ))    }
        let strforcoverimg = dicforresponse["user_cover_img"]
        if(commomcodeobj.StringIsNotEmpty(aStrVal: strforcoverimg! as! String))
  {
            coverimg.image = UIImage(data: Commoncode().Displayimgfromserver(url: Constant().BASE_URL, Images: strforcoverimg! as! String))
        }
     }
//        
//        
    
   func callWStogetdata(aprofileidref:Int)
    {
       var acotrlobj = UserProfileController()
        acotrlobj.delegate = self
        var amodelobj = profilemodel(profile_id: aprofileidref)
    acotrlobj.getUserProfile(amodel: amodelobj)
getUserData()
        
    }
    @IBAction func backbtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
}
    @IBAction func viewprofile(_ sender: Any) {
        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "viewprofile")
    }
    
    @IBAction func postbtnaction(_ sender: Any) {
        Commoncode().pushVCwithoutanimate(acurrentvc: self, nextvcidentifier: "PostimageVC")
    }
}

