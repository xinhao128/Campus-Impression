//
//  CoursesTableViewController.swift
//  CampusImpression
//
//  Created by 许耀昇 on 2019/3/8.
//  Copyright © 2019年 Xinhao Liang. All rights reserved.
//

import UIKit

class CoursesTableViewController: UITableViewController {
    
    let courses: [String] = ["ICS33", "ECON20B", "EECS180B"]
    let professors: [String] = ["Richard E. Pattis", "Pathik D. Wadhwa", "Henry Lee"]
    let offices: [String] = ["DBH 4062", "SSPB 3279", "DBH 6042"]
    let phones: [String] = ["Phone: 949-824-2704", "Phone: 949-824-8238", "Phone: 949-824-3148"]
    let researches:[String] = ["Microworlds for teaching programming; debugging; computational tools for non computer scientists", "fetal/developmental programming of health and disease risk", "fiber-optics and compound semiconductor technology"]
    var urls: [String] = ["https://www.ics.uci.edu/~pattis/images/pattis.jpg", "https://img.etimg.com/photo/59693971/wadhwa-group-ushers-in-luxury-with-project-w54-in-matunga.jpg","https://www.faculty.uci.edu/ext_img/faculty/5710.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    // Design the TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseCell
        let courseName = courses[indexPath.row]
        let professorName = professors[indexPath.row]
        
        cell.courseName.text = courseName
        cell.professorName.text = professorName
        
        return cell

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let professor = professors[indexPath.row]
        let professorOffice = offices[indexPath.row]
        let professorPhone = phones[indexPath.row]
        let professorResearch = researches[indexPath.row]
        let url = urls[indexPath.row]
        
        let professorInfoController = segue.destination as! ProfessorInfoController
        professorInfoController.ProfessorName = professor
        professorInfoController.ProfessorOffice = professorOffice
        professorInfoController.ProfessorPhone = professorPhone
        professorInfoController.ProfessorResearch = professorResearch
        professorInfoController.ProfessorPhoto = url
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
