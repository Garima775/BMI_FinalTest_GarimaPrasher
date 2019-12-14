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
    
    @IBOutlet weak var heightupdate: UITextField!
    @IBOutlet weak var bmiupdate: UITextField!
    var lastCalculationType: Int?
    var height:Double = 0
       var weight:Double = 0
    
    var dict = [String:AnyObject]()
    
    var db:Firestore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("dict",dict)
    }
    
    @IBAction func calculatenewbmi(_ sender: UIButton) {
        if weightupdate.text != nil && heightupdate.text != nil, var weight = Double(weightupdate.text!), var height = Double(heightupdate.text!) {
                          self.view.endEditing(true)
        
        let BMI: Double = weight / (height * height)
                          let shortBMI = String(format: "%.2f", BMI)
                          var resultText = "BMI-> \(shortBMI): "
                          var descriptor : String?
                   
                          if(BMI < 16.0) { descriptor = "Severe Thinness" }
                          else if(BMI < 16.99) { descriptor = "Moderate Thin" }
                          else if(BMI < 18.49) { descriptor = "Mild Thin" }
                          else if(BMI < 24.99) { descriptor = "Normal" }
                          else if(BMI < 29.99) { descriptor = "Overweight" }
                          else if(BMI < 34.99) { descriptor = "Obese 1" }
                          else if(BMI < 39.99) { descriptor = "Obese 2" }
                          else { descriptor = "Obese 3" }
                   resultText += descriptor!
                   print(resultText)
                   bmiupdate.text = resultText
                  bmiupdate.isHidden = false
                   lastCalculationType = 0
                         
                          
                         
                      }
    }
    
    @IBAction func Update(_ sender: UIButton) {
        
        db = Firestore.firestore()
            

        let parameters = ["Weight":weightupdate.text!,"BMI":bmiupdate.text!,"Height":heightupdate.text!, "docId":dict["docId"]!] as [String : Any]

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
    
