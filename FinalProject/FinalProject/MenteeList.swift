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

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
}
