//
//  MainCell.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/15.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var imvVideo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
