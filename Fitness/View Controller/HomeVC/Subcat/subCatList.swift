//
//  subCatList.swift
//  Fitness
//
//  Created by Namrata Akash on 22/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit
import AVFoundation

class subCatList: UIViewController,UITableViewDataSource,UITableViewDelegate,Homedelegate {
    func homedataresp(arr: [Any]) {
        
    }
    var finalarr  = [Any]();
    
    //    var typeid : String?;
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return finalarr.count;
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeTableViewCell;
        
        
        let dic  = finalarr[indexPath.row] as! [String:Any];
        
        
        let dataval  = dic["sub_cat_name"] as! String
        let imgname = dic["sub_cat_image"] as! String
        
        
        commomcodeobj.setUserdefault(key: "sub_cat_image", val: imgname);
        
        cell.homelbl.text   =  (dataval as! String);
        cell.imgvw.sd_setImage(with: URL(string: "\(Constant.commom_base_url)\(imgname)"), placeholderImage: UIImage(named: "placeholder.png"))
        cell.playbtn.addTarget(self, action: #selector(self.handleplay), for: .touchDragInside);
        cell.discriptionbtn.addTarget(self, action: #selector(self.handlediscription), for: .touchDragInside)
        cell.playbtn.tag  = indexPath.row;
        cell.discriptionbtn.tag = indexPath.row
        
        
        return cell;
        
        
        
        
    }

    
    
    @objc func handlediscription(sender:UIButton)
    {
        let dic  = finalarr[sender.tag] as! [String:Any];
        
        
        let val  = dic["sub_cat_image"] as! String
        let name = dic["sub_cat_name"] as! String
        commomcodeobj.setUserdefault(key: "sub_cat_image", val: val);
        commomcodeobj.setUserdefault(key: "sub_cat_name", val: name);
        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "description")
    }
    @objc func handleplay(sender:UIButton) {
        
        
        let dic  = finalarr[sender.tag] as! [String:Any];
        
        
        let dataval  = dic["Video_data"] as! String;
        
        let url  = "\(Constant.commom_base_url)Videos/\(dataval)";
        
        let videoURL = URL(string: url);
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    @IBOutlet weak var tbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getDataById();
        
        
        // Do any additional setup after loading the view.
    }
    
    func getDataById()  {
        
        
        let cntrlobj  = HomeController();
        cntrlobj.delegate = self;
        
        
        
        cntrlobj.getTypeById(gym_id: commomcodeobj.readUserdefault(key: "Gym_id"));
        
        
        
        
    }
    
    func getByIdResp(arr: [Any]) {
        
        finalarr = arr;
        tbl.reloadData();
        
        
    }
    
    
//
    @IBAction func descriptionbtnclick(_ sender: UIButton) {


//        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "description")
    }
    
    @IBAction func backbtn(_ sender: Any) {
        commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "home")
        
    }
}
