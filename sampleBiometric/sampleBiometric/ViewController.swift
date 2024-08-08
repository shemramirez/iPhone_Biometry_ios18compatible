//
//  ViewController.swift
//  sampleBiometric
//
//  Created by ramirez on 2024/07/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var authenticationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if Authentication.canEvaluateAuthentication() {
            switch Authentication.getAuthenticationType() {
            case .faceID:
                authenticationBtn.imageView?.image = UIImage(systemName: "faceid")
            case .touchID:
                authenticationBtn.imageView?.image = UIImage(systemName: "touchid")
            default:
                redirectToLogin()
                
            }
        } else {
            redirectToLogin()
        }
    }
    
    func redirectToLogin() {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let login = story.instantiateViewController(identifier: "LoginViewController") as LoginViewController
        login.modalPresentationStyle = .overCurrentContext
        navigationController?.present(login, animated: false)
    }
}

