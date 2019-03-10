//
//  TutorInfoViewController.swift
//  CampusImpression
//
//  Created by Jackson Lu on 3/9/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class TutorInfoViewController: UIViewController {

    
    @IBOutlet weak var tutorImage: UIImageView!
    @IBOutlet weak var officehourLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    var image = UIImage()
    var name = ""
    var office_hour = ""
    var contact = ""
    var phone = ""
    var bio = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorImage.layer.cornerRadius = 25.0
        tutorImage.layer.masksToBounds = true
        
        nameLabel.text = name
        tutorImage.image = image
        emailLabel.text = "Email: \(contact)"
        phoneLabel.text = "Phone Number: \(phone)"
        bioLabel.text = "  \(bio)"
        officehourLabel.text = "Office Hour: \(office_hour)"
    
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
