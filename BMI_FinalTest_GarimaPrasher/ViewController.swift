//
//  ViewController.swift
//  BMI_FinalTest_GarimaPrasher
//
//  Created by Garima Prasher on 2019-12-11.
//  Copyright © 2019 Garima Prasher. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var Nametextfield: UITextField!
    
    
    @IBOutlet weak var Agetextfield: UITextField!
    
    @IBOutlet weak var Gendertextfield: UITextField!
    
    
    @IBOutlet weak var Heighttextfield: UITextField!
    
    
    @IBOutlet weak var Weighttextfield: UITextField!
    var dict = [String:AnyObject]()
    var db:Firestore?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Heightswitch(_ sender: UISwitch) {
        
    }
    
    
    @IBAction func Weightswitch(_ sender: UISwitch) {
        
    }
    
    
    
    
    @IBAction func Submit(_ sender: UIButton) {
         db = Firestore.firestore()
               let docId = db?.collection("data").document().documentID

        let parameters = ["name":Nametextfield.text!,"age":Agetextfield.text!,"gender":Gendertextfield.text!, "height":Heighttextfield.text!, "weight": Weighttextfield.text!, "docId":docId!] as [String : Any]

        db?.collection("data").document(docId!).setData(parameters as [String: Any]){
                   err in
                   if let error = err{
                       print(error.localizedDescription)
                       
                   }else{
                       print("document added successfully")
                       let alert = UIAlertController(title: "Message", message: "Successfully added", preferredStyle: .alert)
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
    




