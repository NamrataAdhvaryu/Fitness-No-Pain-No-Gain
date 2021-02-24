//
//  HomeTableViewCell.swift
//  Fitness
//
//  Created by Namrata Akash on 15/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl:UILabel!
   
    @IBOutlet weak var homelbl:UILabel!
    @IBOutlet weak var imgvw:UIImageView!
    @IBOutlet weak var playbtn:UIButton!
    @IBOutlet weak var discriptionbtn:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}
