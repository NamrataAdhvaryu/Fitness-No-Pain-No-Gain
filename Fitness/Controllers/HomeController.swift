//
//  HomeController.swift
//  Fitness
//
//  Created by Namrata Akash on 19/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
@objc protocol Homedelegate {
    @objc optional func homedataresp(arr:[Any])
    
    @objc optional func getByIdResp(arr:[Any])
    @objc optional func getsubIDresp(arr:[Any])
    
    
}

class HomeController: NSObject {
    var delegate:Homedelegate?
    
    func getHomedata()
    {
        
        let url  = "\(Constant.commom_base_url)CompType.php";
        
        let finalurl  = URL(string: url)!;
        
        Commoncall().WScallforRequest(nURL: finalurl) { (resp) in
            self.delegate?.homedataresp!(arr: resp);
            
            print("delegate method called")
        }
        
    }
    
    func getTypeById(gym_id:String)  {
        
        let url  = "\(Constant.commom_base_url)getCatagoryid.php?gym_id=\(gym_id)";
        
        let url1 =  URL(string :url)!
        
        
        Commoncall().WScallforRequest(nURL: url1) { (resp) in
            self.delegate?.getByIdResp!(arr: resp);
            
            print("delegate method called")
        }
    }
      
   
    
}


