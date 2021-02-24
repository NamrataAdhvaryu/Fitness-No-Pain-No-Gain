//
//  Commoncall.swift
//  Fitness
//
//  Created by Namrata Akash on 11/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class Commoncall: NSObject
{
    
    
    func WScallforRequest(nURL:URL, completion: @escaping ([Any]) -> ())
    {
        let nRequest = URLRequest(url: nURL)
        let nsession = URLSession.shared
        let ndatatask = nsession.dataTask(with: nRequest) { (arespdata, aresp, err) in
            let dataresp = String(data: arespdata!, encoding: String.Encoding.utf8);
            print(dataresp);
            
            if(arespdata != nil)
            {
                do
                {
                    let ajsondata = try!
                        JSONSerialization.jsonObject(with: arespdata!, options: []) as! [Any]
                    DispatchQueue.main.async {
                        completion(ajsondata)
                        
                    }
                }
                catch let aerr as NSError
                {
                    print(aerr.description)
                }
            }
        }
        ndatatask.resume()
    }
    
    func WScallforpost(aurl:URL, arefstring:String,completion: @escaping ([Any]) -> () )
    {
        var anrequest = URLRequest(url: aurl)
        anrequest.addValue(String(arefstring.count), forHTTPHeaderField: "Content_Length")
        anrequest.httpBody = arefstring.data(using: String.Encoding.utf8)
        anrequest.httpMethod = "POST"
        let ansession = URLSession.shared
        let andatatask = ansession.dataTask(with: anrequest)
        { (andata, anresp, anerr) in
            if(andata != nil)
            {
                let arresp = String(data: andata!, encoding: String.Encoding.utf8)
                print(arresp as Any)
                do
                {
                    let  anjsondata = try
                        JSONSerialization.jsonObject(with: andata!, options: []) as! [Any]
                    print(anjsondata)
                    
                    DispatchQueue.main.async {
                        completion(anjsondata);
                    }
                }
                catch let anerr as NSError
                {
                    print(anerr.description)
                }
            }
            
            
        }
        
    
        andatatask.resume()
        
    }
}
    
//func WSCallForPost(aURLRef:URL, aParamRef:String,completion: @escaping ([Any])->())
//{
//
//    var aRequestObj = URLRequest(url: aURLRef);
//    aRequestObj.addValue(String(aParamRef.count), forHTTPHeaderField: "Content-Length");
//    aRequestObj.httpBody  = aParamRef.data(using: String.Encoding.utf8);
//    aRequestObj.httpMethod = "POST";
//
//    let aSessionObj = URLSession.shared;
//    let aDataTaskObj  = aSessionObj.dataTask(with: aRequestObj)
//    { (aDataRef, aResponseRef, err) in
//
//    if(aDataRef != nil)
//     {
//        let aStrResponseRef  = String(data: aDataRef!, encoding: String.Encoding.utf8);
//        print(aStrResponseRef);
//        do
//        {
//            let aArrJsonResponse  = try JSONSerialization.jsonObject(with: aDataRef!, options: []) as! [Any];
//
//            DispatchQueue.main.async
//            {
//                completion(aArrJsonResponse);
//            }
//        }
//        catch
//        {
//        }
//
//        }
//    }
//    aDataTaskObj.resume();
//}
//}
