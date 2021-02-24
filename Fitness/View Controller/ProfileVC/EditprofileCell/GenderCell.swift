//
//  GenderCell.swift
//  Fitness
//
//  Created by Namrata Akash on 30/10/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class GenderCell: UITableViewCell {
    @IBOutlet weak var lblgender: UILabel!
    @IBOutlet weak var btnmale: UIButton!
    @IBOutlet weak var btnfemale: UIButton!
    @IBOutlet weak var btnother: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
