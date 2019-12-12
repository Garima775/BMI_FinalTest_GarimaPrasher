//File Name: Viewcontroller.swift
//Author Name: Garima Prasher
//student id: 301093329
//DATE : 11 Dec 2019

import UIKit
import Firebase


class ViewController: UIViewController
{

    @IBOutlet weak var resultlabel: UITextField!
    @IBOutlet weak var Nametextfield: UITextField!
    
    @IBOutlet weak var HeightSwitch: UISwitch!
    
    @IBOutlet weak var Agetextfield: UITextField!
    
    @IBOutlet weak var Gendertextfield: UITextField!
    
    
    @IBOutlet weak var Heighttextfield: UITextField!
    
    
    @IBOutlet weak var Weighttextfield: UITextField!
    var dict = [String:AnyObject]()
    var db:Firestore?
    var height:Int = 0
    var weight:Int = 0
    var bmi:Int = 0
    var lastCalculationType: Int?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Heightswitch(_ sender: UISwitch) {
        weight = Int(self.Weighttextfield.text!)!
        height = Int(self.Heighttextfield.text!)!
        print("weight height is",weight,height)
        
        height = height * 39
        
        bmi = weight*703/height*height
        print("bmi is",bmi)
       
    }
    
    
  
    
    
    
    @IBAction func Submit(_ sender: UIButton) {
         db = Firestore.firestore()
               let docId = db?.collection("data").document().documentID
        if Weighttextfield.text != nil && Heighttextfield.text != nil, var weight = Double(Weighttextfield.text!), var height = Double(Heighttextfield.text!) {
                   self.view.endEditing(true)
                   //Calculating BMI using metric, so convert to metric first
            if (HeightSwitch.isOn == true) {
                       (weight) *= 0.453592;
                       (height) *= 0.0254;
                   }
                   let BMI: Double = weight / (height * height)
                   let shortBMI = String(format: "%.2f", BMI)
                   var resultText = "Your BMI is \(shortBMI): "
                   var descriptor : String?
                   if(BMI < 16.0) { descriptor = "Severely Thin" }
                   else if(BMI < 16.99) { descriptor = "Moderately Thin" }
                   else if(BMI < 18.49) { descriptor = "Slightly Thin" }
                   else if(BMI < 24.99) { descriptor = "Normal" }
                   else if(BMI < 29.99) { descriptor = "Overweight" }
                   else if(BMI < 34.99) { descriptor = "Moderately Obese" }
                   else if(BMI < 39.99) { descriptor = "Severely Obese" }
                   else { descriptor = "Very Severely Obese" }
            resultText += descriptor!
            print(resultText)
            resultlabel.text = resultText
            resultlabel.isHidden = false
            lastCalculationType = 0
                  
                   
                  
               }
               else {
            
                resultlabel.text = "Please fill out your height and weight."
                resultlabel.isHidden = false
                lastCalculationType = 0
            }
                  
    
    
        let parameters = ["name":Nametextfield.text!,"age":Agetextfield.text!,"gender":Gendertextfield.text!, "height":Heighttextfield.text!, "weight": Weighttextfield.text!, "bmi": resultlabel.text!, "docId":docId!] as [String : Any]

    db?.collection("data").document(docId!).setData(parameters as [String: Any]){
                   err in
                   if let error = err{
                       print(error.localizedDescription)
                       
                   }else{
                       print("document added successfully")
                       let alert = UIAlertController(title: "Message", message: "It is Added", preferredStyle: .alert)
                       let okay = UIAlertAction(title: "OK", style: .default, handler: { (action) in
        //                   self.navigationController?.popViewController(animated: true)
                        self.performSegue(withIdentifier: "click", sender: nil)
                       })
                       alert.addAction(okay)
                       self.present(alert, animated: true, completion: nil)
                   }
            
            
            }

            }
                
            
   

    




}
