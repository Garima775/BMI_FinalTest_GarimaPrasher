//
//  
//  BMI_FinalTest_GarimaPrasher
//File Name: Viewcontroller.swift
//Author Name: Garima Prasher
//student id: 301093329
//DATE : 11 Dec 2019
//
//  Created by Garima Prasher on 2019-12-13.
//  Copyright © 2019 Garima Prasher. All rights reserved.
//

import UIKit
import Firebase

class ViewController3: UIViewController {
    
    
    @IBOutlet weak var weightupdate: UITextField!
    
    @IBOutlet weak var bmiupdate: UITextField!
    
    var dict = [String:AnyObject]()
    
    var db:Firestore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Update(_ sender: UIButton) {
        
        db = Firestore.firestore()
            

            let parameters = ["Weight":weightupdate.text!,"BMI":bmiupdate.text!,"docId":dict["docId"]!] as [String : Any]

             db?.collection("data").document((dict["docId"] as? String)!).updateData(parameters as [String : Any]){
                 err in
                 if let error = err{
                     print(error.localizedDescription)
                     
                 }else{
                     print("document added successfully")
                     
                     let alert = UIAlertController(title: "Message", message: "Successfully Updated", preferredStyle: .alert)
                     let okay = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                         self.navigationController?.popViewController(animated: true)
                     })
                     alert.addAction(okay)
                     self.present(alert, animated: true, completion: nil)
                     
                     
                 }

             }
        }
        
    }
    
