//
//  MainScreen.swift
//  FinalProject
//
//  Created by Sowmya Ravi on 12/15/16.
//  Copyright © 2016 Sowmya Ravi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainScreen: UIViewController {
    
    

    @IBOutlet weak var LeadingConstraint: NSLayoutConstraint!
    var menuShowing = false
    
    @IBOutlet weak var Name: UILabel!
    @IBAction func Logout(_ sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil{
            do{
                try? FIRAuth.auth()?.signOut()
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")as!  ViewController
                self.present(loginVC, animated: true, completion: nil)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
    }
    
    func checkIfUserLoggedIn(){
        if FIRAuth.auth()?.currentUser?.uid != nil {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("user").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                   self.Name.text = dictionary["name"] as? String
                }
                
                
                }, withCancel: nil)
        }
    }

      @IBAction func OpenMenu(_ sender: AnyObject) {
        if(menuShowing){
            LeadingConstraint.constant = -140
        }else{
            LeadingConstraint.constant = 0
        }
        menuShowing = !menuShowing
        
        
    }
}
