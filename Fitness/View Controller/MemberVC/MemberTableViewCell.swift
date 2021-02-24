//
//  MemberTableViewCell.swift
//  Fitness
//
//  Created by Namrata Akash on 04/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit


class MemberTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
