//
//  PostTitleCell.swift
//  Fitness
//
//  Created by Namrata Akash on 21/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class PostTitleCell: UITableViewCell {
    
    @IBOutlet weak var imgbtn: UIButton!
    @IBOutlet weak var titlebtn: UIButton!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var timeview: UIImageView!
    @IBOutlet weak var btnmore: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
