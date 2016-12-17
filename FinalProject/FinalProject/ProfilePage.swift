//
//  ProfilePage.swift
//  FinalProject
//
//  Created by Sowmya Ravi on 12/16/16.
//  Copyright © 2016 Sowmya Ravi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAnalytics


class ProfilePage: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var Skills: UITextField!
    @IBOutlet weak var PickerUI: UIPickerView!
    @IBOutlet weak var Summary: UITextView!
    @IBOutlet weak var Position: UITextField!
    @IBOutlet weak var NameText: UITextField!
    
    
    var pickerDataSource = ["Mentor", "Mentee"]
    var placement = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myColor : UIColor = UIColor.lightGray
        Summary.layer.borderColor = myColor.cgColor
        Summary.layer.borderWidth = 1.0
        
        self.PickerUI.dataSource = self
        self.PickerUI.delegate = self
        
        
        
        
        checkIfUserLoggedIn()
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfilePage.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        ScrollView.addGestureRecognizer(tapGesture)
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfilePage.handleSelectProfileImageView))
        ProfileImage.isUserInteractionEnabled = true
       // tapGesture.cancelsTouchesInView = true
        ProfileImage.addGestureRecognizer(tap)
        //ProfileImage.alpha = 0.0f
    }
    
    func handleSelectProfileImageView(){
        print(123)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated:true, completion:nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"]{
            selectedImageFromPicker = editedImage as! UIImage
            
            //print((editedImage as AnyObject).size)
            
        }else
            
            if let originalImage = info["UIImagePickerControllerOriginalImage"]{
                selectedImageFromPicker = originalImage as! UIImage
                //print((originalImage as AnyObject).size)
        }
        if let selectedImage = selectedImageFromPicker{
            ProfileImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)

       
        
    }
    

   
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       print("cancelled")
        dismiss(animated: true, completion: nil)
    }
    

 
    
    func checkIfUserLoggedIn(){
        if FIRAuth.auth()?.currentUser?.uid != nil {
            
          
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("user").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    if dictionary["name"] as? String != nil{
                    self.NameText.text = dictionary["name"] as? String
                    }
                    if dictionary["position"] as? String != nil{
                        self.Position.text = dictionary["position"] as? String
                    }

                    if dictionary["skills"] as? String != nil{
                        self.Skills.text = dictionary["skills"] as? String
                    }

                    if dictionary["summary"] as? String != nil{
                        self.Summary.text = dictionary["summary"] as? String
                    }
                   
                    if let i = dictionary["profileImageUrl"] as? String{
                    
                    if let url = NSURL(string: i){
                        if let data = NSData(contentsOf: url as URL){
                            print("sss")
                           
                            DispatchQueue.global(qos: .userInitiated).async{(self.ProfileImage.image = UIImage(data: data as Data))
                            print("rrrr")
                            }
                            
                        }
                    }
                    }
                   
                }
                
                }, withCancel: nil)
        }
    }

    
    @IBAction func SaveInfo(_ sender: AnyObject) {
        
        guard let name = NameText.text, let position = Position.text, let skills = Skills.text, let summary = Summary.text else{
            return
        }
        //let level = pickerDataSource
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(self.ProfileImage.image!){
            storageRef.put(uploadData, metadata: nil, completion:
                {(metadata,error) in
                    
                    if error != nil{
                        print(error)
                        return
                    }
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                        
                    
                    let values = ["name": name, "position": position, "skills": skills, "summary": summary, "level": self.pickerDataSource[self.placement], "profileImageUrl": profileImageUrl]
 
                    self.uploadUserData(uid: uid, values: values as [String : AnyObject])
                    }
                    
                    })
        }
        
        
        
        
       
        
        
        
        
    }
    
    private func uploadUserData(uid: String, values: [String: AnyObject]){
        let ref = FIRDatabase.database().reference(fromURL: "https://apartment-management-b3c9b.firebaseio.com/")
        let userReference = ref.child("user").child(uid)
        userReference.updateChildValues(values, withCompletionBlock: { (err,ref) in
            
            if err != nil{
                print("error is:", err)
                return
            }
            self.view.makeToast("Information Updated")
            print("successfully inserted")
            
            
            
            
        })
        

    }
    
    
    
    
    
    func hideKeyboard(){
        Summary.resignFirstResponder()
        Position.resignFirstResponder()
        NameText.resignFirstResponder()
        Skills.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
       func textViewDidBeginEditing(_ textView: UITextView) {
        ScrollView.setContentOffset(CGPoint(x:0,y:250), animated: true)

    }
    func textViewDidEndEditing(_ textView: UITextView) {
       ScrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerDataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placement = row
    }
    
    
    
   }
