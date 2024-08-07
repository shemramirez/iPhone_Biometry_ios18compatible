//
//  ViewController.swift
//  sampleBiometric
//
//  Created by ramirez on 2024/07/29.
//

import UIKit

class ViewController: UIViewController {
    let localAuthentication = Authentication()

    @IBOutlet weak var authenticationImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if localAuthentication.canEvaluateAuthentication() {
            switch localAuthentication.getAuthenticationType() {
            case .faceID:
                authenticationImg.image = UIImage(systemName: "faceid")
            case .touchID:
                authenticationImg.image = UIImage(systemName: "touchid")
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

