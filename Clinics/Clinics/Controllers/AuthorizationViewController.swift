//
//  AuthorizationViewController.swift
//  Clinics
//
//  Created by Mac on 6/8/22.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var enterView: UIView!
    @IBOutlet weak var registerView: UIView!
    
    @IBOutlet weak var loginEnter: UITextField!
    @IBOutlet weak var passwordEnter: UITextField!
    
    @IBOutlet weak var loginRegister: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
    @IBOutlet weak var repeatPasswordRegister: UITextField!
    @IBOutlet weak var agreeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterView.isHidden = false
        registerView.isHidden = true
    }
    
    // MARK: IBActions
    @IBAction func segmentedControl(_ sender: Any) {
        let segControl: UISegmentedControl = sender as! UISegmentedControl
        let select = segControl.selectedSegmentIndex
        
        if (select == 0) {
            enterView.isHidden = false
            registerView.isHidden = true
            loginRegister.text = ""
            emailRegister.text = ""
            passwordRegister.text = ""
            repeatPasswordRegister.text = ""
            loginEnter.text = ""
            passwordEnter.text = ""
        } else {
            enterView.isHidden = true
            registerView.isHidden = false
            loginRegister.text = ""
            emailRegister.text = ""
            passwordRegister.text = ""
            repeatPasswordRegister.text = ""
            loginEnter.text = ""
            passwordEnter.text = ""
        }
    }
    
    @IBAction func enterButton(_ sender: Any) {
        if (loginEnter.text! != "" && passwordEnter.text! != "") {
            
            if let login = UserDefaults.standard.object(forKey: "login") {
                if let password = UserDefaults.standard.object(forKey: "password") {
                    if (login as? String == loginEnter.text! && password as? String == passwordEnter.text!) {
                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewController") as? MapViewController {
                            self.navigationController?.pushViewController(vc, animated: true)
                            loginRegister.text = ""
                            emailRegister.text = ""
                            passwordRegister.text = ""
                            repeatPasswordRegister.text = ""
                            loginEnter.text = ""
                            passwordEnter.text = ""
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if (loginRegister.text! != "" && passwordRegister.text! != "" && emailRegister.text! != "" && repeatPasswordRegister.text! != "" && agreeSwitch.isOn) {
            if (passwordRegister.text! == repeatPasswordRegister.text!) {
                UserDefaults.standard.setValue(loginRegister.text!, forKey: "login")
                UserDefaults.standard.setValue(passwordRegister.text!, forKey: "password")
                UserDefaults.standard.setValue(emailRegister.text!, forKey: "email")
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewController") as? MapViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    loginRegister.text = ""
                    emailRegister.text = ""
                    passwordRegister.text = ""
                    repeatPasswordRegister.text = ""
                    loginEnter.text = ""
                    passwordEnter.text = ""
                }
            }
        }
    }
    
}
