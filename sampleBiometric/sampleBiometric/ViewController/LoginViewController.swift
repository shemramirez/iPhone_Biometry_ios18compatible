//
//  LoginViewController.swift
//  sampleBiometric
//
//  Created by ramirez on 2024/07/31.
//

import UIKit

class LoginViewController: TextFieldViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var completion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickLoginBtn(_ sender: Any) {
        dismiss(animated: false, completion: self.completion)
    }
}
