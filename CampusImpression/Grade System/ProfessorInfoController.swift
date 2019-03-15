//
//  ProfessorInfoController.swift
//  CampusImpression
//
//  Created by 许耀昇 on 2019/3/9.
//  Copyright © 2019年 Xinhao Liang. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfessorInfoController: UIViewController {
    
    @IBOutlet weak var professorPhoto: UIImageView!
    
    @IBOutlet weak var professorName: UILabel!
    
    
    @IBOutlet weak var professorOffice: UILabel!
    
    @IBOutlet weak var professorPhone: UILabel!
    
    @IBOutlet weak var professorResearch: UILabel!
    
    @IBOutlet weak var gradeView: UIImageView!
    
    var ProfessorName: String = ""
    var ProfessorOffice: String = ""
    var ProfessorPhone: String = ""
    var ProfessorResearch: String = ""
    var ProfessorPhoto: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        professorName.text = ProfessorName
        professorOffice.text = ProfessorOffice
        professorPhone.text = ProfessorPhone
        professorResearch.text = ProfessorResearch
        let posterPath = ProfessorPhoto
        let posterUrl = URL(string: posterPath)
        professorPhoto.af_setImage(withURL: posterUrl!)
        
//        let graphUrl = URL(string: "file:///Users/xuyaosheng/Desktop/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-03-09%20%E4%B8%8B%E5%8D%888.45.06.png")
//        gradeView.af_setImage(withURL: graphUrl!)

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
