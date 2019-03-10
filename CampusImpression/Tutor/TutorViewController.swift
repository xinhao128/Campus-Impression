//
//  TutorViewController.swift
//  CampusImpression
//
//  Created by Jackson Lu on 3/9/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class TutorViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var applyButton: UIButton!
    
    
    var tutor_name_list = ["Jackson Anteater","Xinhao Anteater", "Charlotte Anteater"]
    var office_hour_list = ["TuTh 5pm-6pm","MWF 2pm-3:30pm","MTh 7:00pm-8:pm"]
    var tutor_image_list = ["sample_1","sample_2", "sample_3"]
    var contact_list = ["xxx@uci.edu","xxx@uci.edu","xxx@uci.edu"]
    var phone_list = ["949-xxx-xxxx","949-xxx-xxxx","949-xxx-xxxx"]
    var bio_list = ["Hello world","UCI ZOT! ZOT!","Welcome"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutor_name_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "TutorCell") as! TutorCell
        
        let tutor_name = tutor_name_list[indexPath.row]
        let office_hour = office_hour_list[indexPath.row]
        let tutor_image = tutor_image_list[indexPath.row]
        
        cell.nameLabel.text = tutor_name
        cell.officehourLabel.text = "Office Hour: \(office_hour)"
        cell.tutorImage.image = UIImage(named: tutor_image)
        cell.tutorImage.layer.cornerRadius = 25.0
        cell.tutorImage.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TutorInfoViewController") as? TutorInfoViewController
        
        vc?.image = UIImage(named: tutor_image_list[indexPath.row])!
        vc?.name = tutor_name_list[indexPath.row]
        vc?.office_hour = office_hour_list[indexPath.row]
        vc?.contact = contact_list[indexPath.row]
        vc?.bio = bio_list[indexPath.row]
        vc?.phone = phone_list[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyButton.layer.cornerRadius = 25.0
        applyButton.layer.masksToBounds = true
        
        tableview.dataSource = self
        tableview.delegate = self

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

