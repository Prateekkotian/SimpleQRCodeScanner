//
//  ViewController.swift
//  SimpleQRCodeScanner
//
//  Created by Prateek kumar on 10/30/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTextField.delegate = self
        nameTextField.delegate = self
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let mobile = mobileTextField.text else { return }
        guard let name = nameTextField.text else { return }
        if name.isEmpty || mobile.isEmpty {
            self.displayAlert(message: "Please fill all the fields")
        } else {
            if isValidMobile(mobile: mobile) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "\(OtpViewController.self)") as! OtpViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.displayAlert(message: "Please enter the valid mobile number")
            }
        }
    }
    
    private func isValidMobile(mobile: String) -> Bool {
        if mobile.count != 10 {
            return false
        }
        return true
    }
    
    private func displayAlert(message: String) {
        let errorAlert = UIAlertController(title: "Error",
                                           message: message,
                                           preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


