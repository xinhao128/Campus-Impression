//
//  FeedbackViewController.swift
//  CampusImpression
//
//  Created by apple on 2019/3/12.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet var RatingOfCourse: [UIButton]!
    @IBOutlet var DifficultyOfCourse: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RatingOfCourseAction(_ sender: UIButton) {
        let tag = sender.tag
        for button in RatingOfCourse {
            if button.tag <= tag {
                //selected
                button.setTitle("★", for: .normal)
                button.setTitleColor(.black, for: .normal)
            } else {
                //not selected
                button.setTitle("☆", for: .normal)
                button.setTitleColor(.gray, for: .normal)
            }
        }
        
    }
    
    @IBAction func DifficultyOfCourseAction(_ sender: UIButton) {
        let tag = sender.tag
        for button in DifficultyOfCourse {
            if button.tag <= tag {
                //selected
                button.setTitle("★", for: .normal)
                button.setTitleColor(.black, for: .normal)
            } else {
                //not selected
                button.setTitle("☆", for: .normal)
                button.setTitleColor(.gray, for: .normal)
            }
        }
        print(tag)
    }
    
    @IBAction func SubmitButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
