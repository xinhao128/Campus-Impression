//
//  ActionCell.swift
//  CampusImpression
//
//  Created by Chanyue Hu on 3/7/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    @IBAction func onLikeButton(_ sender: Any) {
//    }
//
//    @IBAction func onCommentButton(_ sender: Any) {
//
//    }
}
