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
    var height:Double = 0
    var weight:Double = 0
    var bmi:Double = 0
    var lastCalculationType: Int?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Heightswitch(_ sender: UISwitch) {
        
        
       
    }
    @IBAction func Submit(_ sender: UIButton) {
         db = Firestore.firestore()
               let docId = db?.collection("data").document().documentID
        if Weighttextfield.text != nil && Heighttextfield.text != nil, var weight = Double(Weighttextfield.text!), var height = Double(Heighttextfield.text!) {
                   self.view.endEditing(true)
                   //Calculating BMI using metric, so convert to metric first
//           if (HeightSwitch.isOn == true) {
//                       (weight) *= 0.453592;
//                       (height) *= 0.0254;
//                   }
//            
            
            
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
            resultlabel.text = resultText
            resultlabel.isHidden = false
            lastCalculationType = 0
                  
                   
                  
               }
               else {
            
                resultlabel.text = "Enter your height and weight."
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
