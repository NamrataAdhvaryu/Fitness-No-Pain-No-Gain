//
//  DetailMemberVC.swift
//  Fitness
//
//  Created by Namrata Akash on 04/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import SDWebImage


class DetailMemberVC: UIViewController,UITableViewDataSource,UITableViewDelegate,memberdelegate{
    
    @objc func getBymemberIdResp(arr: [Any]) {
        self.finalarr = arr
        print(finalarr)
        dic = finalarr[0] as! [String:String]
        let strname = dic["sub_Detail"] as! String
        det = strname.components(separatedBy:".")
        print(det)
        tblvw.reloadData()
    }
    
    
    @IBOutlet weak var tblvw: UITableView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var mainlbl: UILabel!
    var finalarr = [Any]()
    var dic = [String:Any]()
    var det = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getdataid()
        
    }
    func getdataid()
    {
        var ctrlbj = MemberController()
        ctrlbj.delegate = self
        
        ctrlbj.getsubTypeById(member_id: commomcodeobj.readUserdefault(key: "member_id"))
        mainlbl.text = commomcodeobj.readUserdefault(key: "member_type_name")
        let image = commomcodeobj.readUserdefault(key: "member_type_images")
        img1.sd_setImage(with: URL(string: "\(Constant.commom_base_url)\(image)"), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return det.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath) as! memberTVC
        
        cell.textLabel?.text = det[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        sectionName = NSLocalizedString("Detail", comment: "sectionmae")
        return sectionName
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "payment")
    }
    
    @IBAction func bkbtn(_ sender: Any) {
        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "membership")
    }
    
    
}
