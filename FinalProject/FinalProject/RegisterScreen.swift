//
//  RegisterScreen.swift
//  FinalProject
//
//  Created by Sowmya Ravi on 12/14/16.
//  Copyright © 2016 Sowmya Ravi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Toast_Swift

class RegisterScreen: UIViewController {

    @IBOutlet var UIView: UIView!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        tapGesture.cancelsTouchesInView = false
        UIView.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func hideKeyboard(){
       Name.resignFirstResponder()
       Password.resignFirstResponder()
       Email.resignFirstResponder()
    }
    
    @IBAction func SignUpButton(_ sender: AnyObject) {
        guard let email = Email.text, let password = Password.text, let name = Name.text else {
            self.view.makeToast("Please fill all fields")
            print("please input fields")
           return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user : FIRUser?, error) in
           
            if error != nil{
                print("User exists")
            }else{
                
                guard let uid = user?.uid else{
                    return
                }
                
                let ref = FIRDatabase.database().reference(fromURL: "https://apartment-management-b3c9b.firebaseio.com/")
                let userReferences = ref.child("user").child(uid)
                let values = ["name": name, "email": email]
                userReferences.updateChildValues(values, withCompletionBlock: { (err,ref) in
                    
                    if err != nil{
                        print(err)
                        return
                    }
                    self.view.makeToast("Account Created Now you can login")
                  print("successfully inserted")
                
                
                
                
                })
                
                
                
            }
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
