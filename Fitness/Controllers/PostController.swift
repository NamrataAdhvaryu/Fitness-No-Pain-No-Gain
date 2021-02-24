//
//  PostController.swift
//  Fitness
//
//  Created by Namrata Akash on 24/12/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

@objc protocol  postdelegate {
   @objc func post_returnresp(ajosondata:[Any])
}

class PostController: NSObject {
    var delegate:postdelegate?
    
    
    func postnew(amodel:Postmodel)
    {
        let url = URL(string: "\(Constant().BASE_URL)userpost.php")
        var arequest = URLRequest(url: url!)
        let session = URLSession.shared
        arequest.addValue(String(amodel.image_list!.count), forHTTPHeaderField: "Content_Length")
        arequest.httpMethod = "POST"
        
        
        let datatask = session.dataTask(with: arequest) { (data, resp, err) in
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                self.delegate?.post_returnresp(ajosondata: json)
                print("delegate method called...")
            }
            catch {
               print("delegate method not called....")
            }
            
        }
        datatask.resume()
    }
    func userPost(aModelObj :Postmodel)
    {
        let aUrlObj  = URL(string: "http://localhost/Fitness/Up.php");
        let aStrBodyObj = "&post_id=\(aModelObj.post_id!)&post_title=\(aModelObj.post_title!)&image_list=\(aModelObj.image_list!)&video_list=\(aModelObj.video_list!)&category=\(aModelObj.category!)&post_description=\(aModelObj.post_description!)&date_time=\(aModelObj.date_time!)&posted_id=\(aModelObj.posted_id!)&post_favourite=\(aModelObj.post_fovourite!)&post_like=\(aModelObj.post_like!)";
  
        if(aUrlObj != nil)
        {
            Commoncall().WScallforpost(aurl: aUrlObj!, arefstring: aStrBodyObj, completion:
            { (result) -> () in
                   print("Delegate method called..");
                self.delegate?.post_returnresp(ajosondata: result)
             });
        }
        else
        {
            print("LOG = Something went wrong...");
        }
    }
    

}
