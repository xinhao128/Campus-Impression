//
//  RatingCell.swift
//  CampusImpression
//
//  Created by apple on 2019/3/11.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class RatingCell: UITableViewCell {
    
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var ProfessorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
