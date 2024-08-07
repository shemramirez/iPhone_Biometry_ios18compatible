//
//  LoginViewController.swift
//  sampleBiometric
//
//  Created by ramirez on 2024/07/31.
//

import UIKit

struct AssociatedKeys {
    static var activeTextField: UInt8 = 0
    
    static var keyboardHeight: UInt8 = 1
}


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension LoginViewController: UITextFieldDelegate {
    
    private(set) var keyboardHeight: CGFloat {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.keyboardHeight) as? CGFloat else {
                return 0.0
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.keyboardHeight, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    func disableUnoccludedTextField() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
        
    func enableUnoccludedTextField() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChangeFrame(notification: Notification) {
        let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            self.keyboardHeight = keyboardFrame.height
    }
        
    @objc func keyboardWillShow(notification: Notification) {
        checkForOcculsion()
    }
        
    @objc func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0.0 {
            self.view.frame.origin.y = 0.0
        }
        self.keyboardHeight = 0.0
    }
    
    private(set) var activeTextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.activeTextField) as? UITextField
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.activeTextField, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    func checkForOcculsion(){
            let bottomOfTextField = self.view.convert(CGPoint(x: 0, y: self.activeTextField!.frame.height), from: self.activeTextField!).y
            let topOfKeyboard = self.view.frame.height - self.keyboardHeight
            
            if (bottomOfTextField > topOfKeyboard ) {
                var offset = bottomOfTextField - topOfKeyboard
                if self.view.frame.origin.y < 0 {
                    offset += 20.0
                }
                self.view.frame.origin.y = -1 * offset
            } else {
                self.view.frame.origin.y = 0
            }
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.activeTextField != nil && self.activeTextField !== textField {
            self.activeTextField = textField
            checkForOcculsion()
        }else{
            self.activeTextField = textField
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}
