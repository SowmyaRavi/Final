//
//  MentorList.swift
//  FinalProject
//
//  Created by Sowmya Ravi on 12/16/16.
//  Copyright © 2016 Sowmya Ravi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class MentorList: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        FIRDatabase.database().reference().child("user").queryOrdered(byChild: "level").queryEqual(toValue: "Mentor").observeSingleEvent(of: .childAdded, with: { snapshot in
            
            print("fetched")
            print(snapshot)
            
            
            
            
            
            
            
            
            }, withCancel: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   
}
