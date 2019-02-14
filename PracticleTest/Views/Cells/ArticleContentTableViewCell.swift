//
//  ArticleContentTableViewCell.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/13/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import UIKit

class ArticleContentTableViewCell: UITableViewCell {

    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var sourceButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
