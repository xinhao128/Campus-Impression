//
//  TutorApplyViewController.swift
//  CampusImpression
//
//  Created by Jackson Lu on 3/9/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class TutorApplyViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0{
            return pm_list.count
        }
        
        return am_list.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if component == 0{
            return am_list[row]
        }
        
        return pm_list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    let am_list = ["12am","1am","2am","3am","4am","5am","6am","7am","8am","9am","10am","11am"]
    let pm_list = ["12pm","1pm","2pm","3pm","4pm","5pm","6pm","7pm","8pm","9pm","10pm","11pm"]
    
    
   
    @IBOutlet weak var nameLabel: UIImageView!
    @IBOutlet weak var ampicker: UIPickerView!
//    @IBOutlet weak var pmpickerView: UIPickerView!
    @IBOutlet weak var emailLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        ampicker.dataSource = self
        ampicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SubmitButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
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
