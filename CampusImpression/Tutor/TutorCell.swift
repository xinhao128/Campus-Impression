//
//  TutorCell.swift
//  CampusImpression
//
//  Created by Jackson Lu on 3/9/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class TutorCell: UITableViewCell {

    @IBOutlet weak var officehourLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var enrollLabel: UIButton!
    @IBOutlet weak var tutorImage: UIImageView!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var openButton: UIButton!
    
    
    @IBAction func openB(_ sender: Any) {
    }
    @IBAction func joinB(_ sender: Any) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
