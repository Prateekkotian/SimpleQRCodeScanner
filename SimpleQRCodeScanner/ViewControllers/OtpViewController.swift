//
//  OtpViewController.swift
//  SimpleQRCodeScanner
//
//  Created by Prateek kumar on 10/30/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit

class OtpViewController: UIViewController {

    @IBOutlet weak var otpTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        otpTextField.delegate = self
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let otp = otpTextField.text else { return }
        if otp != "0000" {
            displayAlert(message: "Please enter 0000")
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "\(MainViewController.self)") as! MainViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
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

extension OtpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



