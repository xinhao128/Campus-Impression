//
//  CourseCell.swift
//  CampusImpression
//
//  Created by 许耀昇 on 2019/3/8.
//  Copyright © 2019年 Xinhao Liang. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var professorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
