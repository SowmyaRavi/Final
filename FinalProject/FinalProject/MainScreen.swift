//
//  MainScreen.swift
//  FinalProject
//
//  Created by Sowmya Ravi on 12/15/16.
//  Copyright © 2016 Sowmya Ravi. All rights reserved.
//

import UIKit

class MainScreen: UIViewController {
    
    

    @IBOutlet weak var LeadingConstraint: NSLayoutConstraint!
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
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
