//
//  DescriptionVC.swift
//  Fitness
//
//  Created by Namrata Akash on 23/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import SDWebImage

class DescriptionVC: UIViewController,Homedelegate,UITableViewDelegate,UITableViewDataSource{
    
    var dic = [String:Any]()
    
    
    @objc func getByIdResp(arr:[Any])
    {
        self.finalarr = arr
        print(finalarr)
        
        dic = finalarr[0] as! [String:String];
        
        let strname  = dic["sub_disadvantages"] as! String;
        
        dis =  strname.components(separatedBy: ".");
        
        
        
        let advantage  = dic["sub_advantages"] as! String;
        
        adv =  advantage.components(separatedBy: ".");
        let discription  = dic["Discription"] as! String;
        
        dix =  discription.components(separatedBy: ".");
        
        
        print(dix)
        print(adv);
        print(dis);
        
         
         
        tbldesp.reloadData();
        
        
    }
    @IBOutlet weak var tbldesp: UITableView!
    @IBOutlet weak var deslbl:UILabel!
    @IBOutlet weak var despimg:UIImageView!
    
    var finalarr  = [Any]()
    var dix = [Any]()
    var adv = [Any]()
    var dis = [Any]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //
        getDataById()
        tbldesp.delegate = self
        tbldesp.dataSource = self
        tbldesp.reloadData()
    }
    
    
    func getDataById()  {
        let cntrlobj  = HomeController();
        cntrlobj.delegate = self;
        
        
        
        cntrlobj.getTypeById(gym_id: commomcodeobj.readUserdefault(key: "Gym_id"));
        
        
        let image = commomcodeobj.readUserdefault(key: "sub_cat_image")
        despimg.sd_setImage(with: URL(string: "\(Constant.commom_base_url)\(image)"), placeholderImage: UIImage(named: "placeholder.png"))
        
        deslbl.text = commomcodeobj.readUserdefault(key: "sub_cat_name")
        
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0)
        {
           return dix.count
        }
        else if (section == 1)
        {
             return adv.count
        }
       else
        {
            return dis.count
        }
           
        }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = UIColor.white
       
        if (indexPath.section == 0)
        {
            
            cell.textLabel?.text  = dix[indexPath.row] as! String;
            
        }
        else if (indexPath.section == 1)
        {
            
            cell.textLabel?.text  = adv[indexPath.row] as! String;
                       
            
            
            //tbldesp.reloadData()
            
            
        }
        else
        {
            
            cell.textLabel?.text  = dis[indexPath.row] as! String;
                                 
                     
           
            
            
        }
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          let sectionName: String
        
        switch section {
            case 0:
                sectionName = NSLocalizedString("Discription", comment: "mySectionName")
            case 1:
                sectionName = NSLocalizedString("Advantages", comment: "myOtherSectionName")
            case 2:
            sectionName = NSLocalizedString("Disadvantages", comment: "myOtherSectionName")
            // ...
            default:
                sectionName = "Section"
        }
        return sectionName

    }
    
    @IBAction func backbtn(_ sender: Any) {
        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "subCatList")
      
    }

 
}

