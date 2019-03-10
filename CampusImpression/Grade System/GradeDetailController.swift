//
//  GradeDetailController.swift
//  CampusImpression
//
//  Created by 许耀昇 on 2019/3/9.
//  Copyright © 2019年 Xinhao Liang. All rights reserved.
//

import UIKit
import AlamofireImage

class GradeDetailController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var quarterPicker: UIPickerView!
    @IBOutlet weak var percentageForA: UILabel!
    @IBOutlet weak var percentageForB: UILabel!
    @IBOutlet weak var percentageForC: UILabel!
    @IBOutlet weak var gradeView: UIImageView!
    
    var pickerData: [String] = ["2018 Fall", "2018 Winter"]
    var percentagesA: [String] = ["37/144   26%", "41/273   15%"]
    var percentagesB: [String] = ["99/144   69%", "128/273   47%"]
    var percentagesC: [String] = ["7/144    5%", "76/273   28%"]
    var urls: [String] = ["file:///Users/xuyaosheng/Desktop/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-03-09%20%E4%B8%8B%E5%8D%888.45.06.png", "file:///Users/xuyaosheng/Desktop/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-03-09%20%E4%B8%8B%E5%8D%888.55.07.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quarterPicker.dataSource = self
        quarterPicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        percentageForA.text = percentagesA[row]
        percentageForB.text = percentagesB[row]
        percentageForC.text = percentagesC[row]
        let final = urls[row]
        let finalUrl = URL(string:final)
        gradeView.af_setImage(withURL: finalUrl!)
    }
    


}
