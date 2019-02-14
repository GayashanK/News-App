//
//  PublisherTableViewCell.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/14/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import UIKit

class PublisherTableViewCell: UITableViewCell {
    @IBOutlet weak var conView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        conView.dropShadow(color: .black, offSet: CGSize(width: 0.0, height: 0.0))
        conView.layer.cornerRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
