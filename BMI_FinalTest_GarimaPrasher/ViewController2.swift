//
//  ViewController2.swift
//  BMI_FinalTest_GarimaPrasher
//
//  Created by Garima Prasher on 2019-12-11.
//  Copyright © 2019 Garima Prasher. All rights reserved.
//

import UIKit
import Firebase

class ViewController2: UIViewController {
    
    @IBOutlet weak var listTable: UITableView!
    var db:Firestore?
    var arr = ["sdada","dasdasd"]
       var dictionary = [[String:AnyObject]]()
       var indexDict = [String:AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
         retrieveData()
        

        // Do any additional setup after loading the view.
    }
    func retrieveData(){
        
        db = Firestore.firestore()
        db?.collection("data").getDocuments(completion: { (snap, err) in
        
            for i in snap!.documents{
                self.dictionary.append(i.data() as [String : AnyObject])
                
            }
            print("dict is",self.dictionary)
            
            self.listTable.reloadData()
        })
        
    }
    

    
}
