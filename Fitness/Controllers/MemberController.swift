//
//  MemberController.swift
//  Fitness
//
//  Created by Namrata Akash on 01/10/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
@objc protocol memberdelegate {
    @objc optional func memberdataresp(arr:[Any])
     @objc optional func getBymemberIdResp(arr:[Any])
}

class MemberController: NSObject {
  var delegate:memberdelegate?
    
    func getmemberdata()
    {
        
        let url  = "\(Constant.commom_base_url)member.php";
        
        let finalurl  = URL(string: url)!;
        
        Commoncall().WScallforRequest(nURL: finalurl) { (resp) in
            self.delegate?.memberdataresp!(arr: resp);
            
            print("delegate method called")
        }
        
    }
    func getsubTypeById(member_id:String)  {
              
              let url  = "\(Constant.commom_base_url)getsubCatagoryid.php?member_id=\(member_id)";
              
              let url1 =  URL(string :url)!
              
              
              Commoncall().WScallforRequest(nURL: url1) { (resp) in
                  self.delegate?.getBymemberIdResp!(arr: resp);
                  
                  print("delegate method called")
              }
          }

}
