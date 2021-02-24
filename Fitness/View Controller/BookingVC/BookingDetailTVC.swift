//
//  BookingDetailTVC.swift
//  Fitness
//
//  Created by Namrata Akash on 23/12/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class BookingDetailTVC: UITableViewCell {
    @IBOutlet weak var detaildate: UILabel!
    @IBOutlet weak var detailtime:UILabel!
    @IBOutlet weak var detailclass:UILabel!
    @IBOutlet weak var detailarea:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
