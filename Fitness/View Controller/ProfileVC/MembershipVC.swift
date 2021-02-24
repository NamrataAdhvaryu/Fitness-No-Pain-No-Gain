//
//  MembershipVC.swift
//  Fitness
//
//  Created by Namrata Akash on 04/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import SDWebImage

   
class MembershipVC: UIViewController,UITableViewDelegate,UITableViewDataSource,memberdelegate {
    
    func memberdataresp(arr: [Any]) {
        self.brr = arr
        tableviewmember.reloadData()
        
        
    }
   var brr = [Any]()
    
    
    @IBOutlet weak var tableviewmember: UITableView!
    let commomcodeobj = Commoncode()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewmember.delegate = self
        tableviewmember.dataSource = self
        getmemberdata()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brr.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membercell", for: indexPath) as! MemberTableViewCell
       let dic  = brr[indexPath.row] as! [String:Any];
              
              
              let dataval  = dic["member_type_name"]
              let imgname = dic["member_type_images"] as! String
              
        cell.lbl.text =  (dataval as! String);
        cell.img.sd_setImage(with: URL(string: "\(Constant.commom_base_url)\(imgname)"), placeholderImage: UIImage(named: "placeholder.png"))
              
            
              return cell
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           
         let dic  = brr[indexPath.row] as! [String:Any]
        let dataval  = dic["member_type_name"] as! String
         let imgname = dic["member_type_images"] as! String
                    
        let memberid = dic["member_id"] as! String
        commomcodeobj.setUserdefault(key: "member_type_name", val: dataval)
        commomcodeobj.setUserdefault(key: "member_type_images", val: imgname)
        commomcodeobj.setUserdefault(key: "member_id", val: memberid)
        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "membertype")
           
           
           
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    func getmemberdata()
    {
    let memberobj = MemberController()
        memberobj.delegate = self
        memberobj.getmemberdata()
    
   
}
}
