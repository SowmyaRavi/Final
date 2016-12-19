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

struct MeteeLis{
    let name : String!
    let email : String!
    let uid : String!
    
    
}


class MenteeList: UITableViewController {

    var list = [MeteeLis]()
    var ee = String()
    var label = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRDatabase.database().reference().child("user").queryOrdered(byChild: "level").queryEqual(toValue: "Mentee").observe(.childAdded, with: { snapshot in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let uid = snapshot.key
                let name = dictionary["name"] as! String
                let email = dictionary["email"] as! String
                
                self.list.insert(MeteeLis(name:name, email: email, uid: uid), at: 0)
                self.tableView.reloadData()
                
                
            }
            print("fetched")
            print(snapshot)
            
            
            
            
            
            
            
            
            }, withCancel: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let uid = FIRAuth.auth()?.currentUser?.uid
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2")
        let label1 = cell?.viewWithTag(1)  as! UILabel
        label1.text = list[indexPath.row].name
        
        let label2 = cell?.viewWithTag(2)   as! UILabel
        label2.text = list[indexPath.row].email
        
        let label3 = cell?.viewWithTag(3)  as! UILabel
        label3.text = list[indexPath.row].uid
        
        
        
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        let label1 = currentCell.viewWithTag(3) as! UILabel
        label = label1.text!
        print(label)
        performSegue(withIdentifier: "mentee", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // var viewController = segue
        // your new view controller should have property that will store passed value
        
        
        if let destinationVC = segue.destination as? MenteeDetailView{
            
            destinationVC.text = label
            
        }
 
    }
}
