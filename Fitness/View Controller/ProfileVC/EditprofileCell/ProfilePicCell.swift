//
//  ProfilePicCell.swift
//  Fitness
//
//  Created by Namrata Akash on 30/10/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class ProfilePicCell: UITableViewCell {
    @IBOutlet weak var coverpic: UIImageView!
    @IBOutlet weak var profilepic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
