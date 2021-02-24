//
//  DobCell.swift
//  Fitness
//
//  Created by Namrata Akash on 30/10/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class DobCell: UITableViewCell {
    @IBOutlet weak var lbldb: UILabel!
    @IBOutlet weak var lblvalue: UILabel!
    @IBOutlet weak var calenderbtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
