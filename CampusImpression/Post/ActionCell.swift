//
//  ActionCell.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/6/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {

    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
