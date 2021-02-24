//
//  HomeVC.swift
//  Fitness
//
//  Created by Namrata Akash on 10/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController,UITableViewDataSource, UITableViewDelegate,Homedelegate {
    
    
    func homedataresp(arr: [Any]) {
        
        self.arr  = arr;
        
        hometableview.reloadData()
    }
    
    var constantobj = Constant()
    var commomcodeobj = Commoncode()
    @IBOutlet weak var hometableview: UITableView!
    
    @IBOutlet weak var welcometxt: UILabel!
    var arr = [Any]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpdata();
        getdata();
        
        
    }
    
    
    func setUpdata()  {
        hometableview.delegate = self
        hometableview.dataSource = self
        let dic = commomcodeobj.readPlist(aStrPlistNameRef: constantobj.USER_LOGIN_PLIST)
        let name = dic["name"]! as String
        welcometxt.textColor = constantobj.COLOUR_APP_THEME_PRIMARY
        welcometxt.text = "Fitness club welcomes you,\(name) !!"
        
    }
    
    func getdata()  {
        let  homeobj  = HomeController();
        homeobj.delegate  = self;
        homeobj.getHomedata()
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeTableViewCell
        
        let dic  = arr[indexPath.row] as! [String:Any];
        
        
        let dataval  = dic["Gym_Type_name"]
        let imgname = dic["Gym_cover_image"] as! String
        
        cell.lbl.text =  (dataval as! String);
        cell.imgvw.sd_setImage(with: URL(string: "\(Constant.commom_base_url)\(imgname)"), placeholderImage: UIImage(named: "placeholder.png"))
        
        //cell.imgvw.image =
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dic  = arr[indexPath.row] as! [String:Any];
    
        let val  = dic["Gym_id"] as! String;
        
        commomcodeobj.setUserdefault(key: "Gym_id", val: val);
    
        
        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "subCatList");
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    
}
