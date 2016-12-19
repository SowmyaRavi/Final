//
//  MentorDetailView.swift
//  FinalProject
//
//  Created by Sowmya Ravi on 12/17/16.
//  Copyright © 2016 Sowmya Ravi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MentorDetailView: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    var text:String?
    @IBOutlet weak var picture: UIImageView!

    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var skills: UITextView!
    
        
    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var summary: UITextView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picture.layer.borderWidth = 1
        picture.layer.masksToBounds = false
        picture.layer.borderColor = UIColor.black.cgColor
        picture.layer.cornerRadius = picture.frame.height/2
        picture.clipsToBounds = true

        let uid = text
       
            FIRDatabase.database().reference().child("user").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                   let name = dictionary["name"] as? String
                    if name != nil{
                        self.label1.text = name
                    }
                    
                    let email = dictionary["email"] as? String
                    if email != nil{
                        self.email.text = name
                    }

                   let skills = dictionary["skills"] as? String
                    
                    if skills != nil{
                        self.skills.text = name
                    }
                    let position = dictionary["position"] as? String
                    if position != nil{
                        self.position.text = name
                    }
                    let summary = dictionary["summary"] as? String
                    if summary != nil{
                        self.summary.text = name
                    }
                    let i = dictionary["profileImageUrl"] as? String
                    if(i != nil){
                        
                        let url = NSURL(string: i!)
                        if let data = NSData(contentsOf: url as! URL){
                            print("sss")
                            self.picture.image = UIImage(data: data as Data)
                            print("rrrr")
                        }
                        
                    }
                    
                }
              
        
           }, withCancel: nil)
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    

    
}
