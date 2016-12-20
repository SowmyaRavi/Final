//
//  ViewController.swift
//  FinalProject
//
//  Created by Sowmya Ravi on 12/6/16.
//  Copyright © 2016 Sowmya Ravi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Toast_Swift

class ViewController: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet var UIView: UIView!
    @IBAction func RegisterButton(_ sender: AnyObject) {
              
        
    }
    
    @IBAction func SignInButton(_ sender: AnyObject) {
        guard let email = NameTextField.text, let password = PasswordTextField.text, !email.isEmpty, !password.isEmpty else{
            self.view.makeToast("Please input all fields")
             print("please fill in fields")
            return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {
            user, error in
            
            if error != nil{
                self.view.makeToast("Incorrect Username or Password")
                print("incorrect Username or Password")
            }else{
                self.performSegue(withIdentifier: "login", sender: self)
                
            }
        })
    }
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
       tapGesture.cancelsTouchesInView = false
        UIView.addGestureRecognizer(tapGesture)
    }
    
   func hideKeyboard(){
        NameTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
    }
   
}

