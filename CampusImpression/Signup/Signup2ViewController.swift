//
//  Signup2ViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 2/23/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse

class Signup2ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var usernameField: String?
    var UCIEmailField: String?
    var passwordField: String?
    var inputText: String?
    
    var currentTextField = UITextField()
    
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    var gender = ["male", "female"]
    var major = ["Computer Science", "Economics", "Informatics", "Psychology", "Sociology"]
    
    @IBOutlet weak var genderField: UITextField?
    @IBOutlet weak var majorField: UITextField?
    @IBOutlet weak var birthdayField: UITextField?
    @IBOutlet weak var hometownField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        currentTextField.delegate = self
        genderField?.delegate = self
        majorField?.delegate = self
        
        createPickers()
    }

    func createPickers() {
        genderField?.inputView = pickerView
        majorField?.inputView = pickerView
        
        birthdayField?.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(Signup2ViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Signup2ViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        birthdayField?.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == genderField {
            return gender.count
        }
        else if currentTextField == majorField {
            return major.count
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == genderField {
            return gender[row]
        }
        else if currentTextField == majorField {
            return major[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == genderField {
            genderField?.text = gender[row]
        }
        else if currentTextField == majorField {
            majorField?.text = major[row]
        }
    }
    
    @IBAction func onSignup(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField
        user.password = passwordField
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "SignupSegue", sender: nil)
                let profile = PFObject(className: "Profiles")
                profile["user"] = PFUser.current()!
                profile["UCIEmail"] = self.UCIEmailField
                profile["gender"] = self.genderField?.text
                profile["birthday"] = self.birthdayField?.text
                profile["hometown"] = self.hometownField?.text
                profile["major"] = self.majorField?.text
                profile.saveInBackground{ (success, error) in
                    if success {
                        print("saved profile successfully")
                    } else {
                        print("error!")
                    }
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
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
