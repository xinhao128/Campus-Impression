//
//  EnrollClassViewController.swift
//  CampusImpression
//
//  Created by Jackson Lu on 3/11/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class EnrollClassViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    let defaults = UserDefaults.standard
    var currentTextField = UITextField()
    var currentItem = ""
    
    let pickerView = UIPickerView()
    
    var department_list = ["ECON","ICS","EECS"]

    var course_number_list = ["20B","31","180A"]
    
    @IBOutlet weak var departmentField: UITextField?
    @IBOutlet weak var coursenumberField: UITextField?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        currentTextField.delegate = self
        departmentField?.delegate = self
        coursenumberField?.delegate = self
        
        createPickers()
        addEnrollButtonOnKeyBoard()
        // Do any additional setup after loading the view.
    }
    
    func addEnrollButtonOnKeyBoard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "done", style: UIBarButtonItem.Style.done, target: self, action: #selector(addEnrollButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.departmentField!.inputAccessoryView = doneToolbar
        self.coursenumberField!.inputAccessoryView = doneToolbar
        
    }

    @IBAction func addEnrollButtonAction(_ sender: Any) {
        
        self.view.endEditing(true)
        if currentTextField == departmentField {
            let selectedValue = department_list[pickerView.selectedRow(inComponent: 0)]
            departmentField!.text = selectedValue
        }
        else if currentTextField == coursenumberField {
            
            let selectedValue = course_number_list[pickerView.selectedRow(inComponent: 0)]
            coursenumberField!.text = selectedValue
        }
        
    }
    
    func createPickers(){
        departmentField?.inputView = pickerView
        coursenumberField?.inputView = pickerView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Signup2ViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognize: UIGestureRecognizer){
        view.endEditing(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == departmentField{
            return department_list.count
        }
        else if currentTextField == coursenumberField{
            return course_number_list.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == departmentField{
            return department_list[row]
        }
        else if currentTextField == coursenumberField{
            return course_number_list[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == departmentField{
            departmentField?.text =  department_list[row]
        }
        else if currentTextField == coursenumberField{
            coursenumberField?.text =  course_number_list[row]
        }
    }
    
    @IBAction func EnrollClassAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        
        print("-------department",departmentField!.text!)
        print("-------classnumber",coursenumberField!.text!)
        let newclass = departmentField!.text! + " " + coursenumberField!.text!
        print("-------newclass",newclass)
        defaults.set(newclass, forKey: "newClass")
        defaults.synchronize()
        
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
