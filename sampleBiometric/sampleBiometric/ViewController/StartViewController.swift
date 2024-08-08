//
//  StartViewController.swift
//  sampleBiometric
//
//  Created by ramirez on 2024/08/07.
//

import Foundation
import UIKit

class StartViewController: UIViewController {
    let localAuthentication = Authentication()

    @IBOutlet weak var authenticationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if localAuthentication.canEvaluateAuthentication() {
            switch localAuthentication.getAuthenticationType() {
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


