//
//  NewWordsCell.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/22.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit

class NewWordsCell: UITableViewCell {

    @IBOutlet weak var lblKanji: UILabel!
    @IBOutlet weak var lblHiragana: UILabel!
    @IBOutlet weak var lblTranslate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
