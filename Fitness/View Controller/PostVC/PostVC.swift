//
//  PostVC.swift
//  Fitness
//
//  Created by Namrata Akash on 21/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class PostVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
   
    @IBOutlet weak var posttablevw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 4
       }
       
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTitleCell", for: indexPath) as! PostTitleCell
            return cell
        }
       else if (indexPath.row == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostImageCell
            return cell
        }
       else if(indexPath.row == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostLikecommentCell", for: indexPath) as! PostLikecommentCell
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostDescriptionCell", for: indexPath) as! PostDescriptionCell
            return cell
        }
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0)
        {
           return 111
        }
        else if (indexPath.row == 1)
        {
            return 280
        }
       else if(indexPath.row == 2)
        {
           return 60
        }
        else
        {
           return 400
        }
        
    }
       

}
