//
//  
//  BMI_FinalTest_GarimaPrasher
//File Name: Viewcontroller.swift
//Author Name: Garima Prasher
//student id: 301093329
//DATE : 11 Dec 2019
//file description: this is the third screen or view controller 3 where user can update their weight by adding the value. height will be retrieved from the previous screen table view, and when click on update weight of the user will be updated.
//
//  Created by Garima Prasher on 2019-12-13.
//  Copyright © 2019 Garima Prasher. All rights reserved.
//

import UIKit
import Firebase

class ViewController3: UIViewController {
    
    
    @IBOutlet weak var weightupdate: UITextField!
    
    
    @IBOutlet weak var bmiupdate: UITextField!
    var lastCalculationType: Int?
    var height:Double = 0
    var weight:Double = 0
    var BMI:Double = 0
    var dictionary = [String:AnyObject]()
    var indexDict = [String:AnyObject]()
    var dict = [String:AnyObject]()
    
    var db:Firestore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("dict",dictionary)
    }
    
    @IBAction func calculatenewbmi(_ sender: UIButton) {
        if weightupdate.text != nil, let weight = Double(weightupdate.text!)
        {
                          self.view.endEditing(true)
        
        let BMI: Double = weight / (height * height)
                          let shortBMI = String(format: "%.2f", BMI)
                          var resultText = "BMI is \(shortBMI): "
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
            

        let parameters = ["Weight":weightupdate.text!,"BMI":bmiupdate.text!, "docId":dictionary["docId"]!] as [String : Any]

             db?.collection("data").document((dictionary["docId"] as? String)!).updateData(parameters as [String : Any]){
                 err in
                 if let error = err{
                     print(error.localizedDescription)
                     
                 }else{
                     print("weight updated successfully")
                     
                     let alert = UIAlertController(title: "Message", message: "Successfully Updated", preferredStyle: .alert)
                     let okay = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                      //   self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                     })
                     alert.addAction(okay)
                     self.present(alert, animated: true, completion: nil)
                     
                     
                 }

             }
        }
    
    
        
    }
    
