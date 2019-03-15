//
//  EvaluationViewController.swift
//  CampusImpression
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class EvaluationViewController: UIViewController {
    
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var Course: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CricleImage()
        LoadCourseName()
        // Do any additional setup after loading the view.
    }
    
    func LoadCourseName() {
        courseName.text = Course
    }
    
    func CricleImage() {
        backgroundImage.layer.cornerRadius = backgroundImage.frame.size.width/2
        backgroundImage.clipsToBounds = true
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
