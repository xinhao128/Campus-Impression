//
//  LoginViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 2/23/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse

extension UIViewController{

    func HideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))

        view.addGestureRecognizer(Tap)
    }

    @objc func DismissKeyboard() {

        view.endEditing(true)

    }
}

class LoginViewController: UIViewController {
 
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        
        self.HideKeyboard()
    }
    

    
    @IBAction func userLogin(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                print("login successful")
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
}

