//
//  MenteeList.swift
//  FinalProject
//
//  Created by Sowmya Ravi on 12/16/16.
//  Copyright © 2016 Sowmya Ravi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MenteeList: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    

        FIRDatabase.database().reference().child("user").queryOrdered(byChild: "level").queryEqual(toValue: "Mentee").observeSingleEvent(of: .childAdded, with: { snapshot in
            
            if(!snapshot.exists()){
                print("nothing to display")
            }else{
            
            print("fetched")
            print(snapshot)
            }
            
            }, withCancel: nil)
        

    }

       
}
