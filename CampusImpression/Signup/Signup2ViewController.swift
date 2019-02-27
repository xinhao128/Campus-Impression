//
//  Signup2ViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 2/23/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class Signup2ViewController: UIViewController {
    
    var usernameField: String?
    var UCIEmailField: String?
    var passwordField: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        print(usernameField!)
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
