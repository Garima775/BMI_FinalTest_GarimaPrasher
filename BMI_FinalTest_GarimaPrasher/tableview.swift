//File Name: Viewcontroller.swift
//Author Name: Garima Prasher
//student id: 301093329
//DATE : 11 Dec 2019
//File description: this is the second view controller or table view controller. Data will be fetched from the first profile screen and in this screen, name, height, bmi and weight of the person will be shown. Edit button will help the user to enter into the last screen that is Update screen

import UIKit
import Firebase

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listTable: UITableView!  //connected with the table view
    var db:Firestore?
    var arr = ["sdada","dasdasd"]
       var dictionary = [[String:AnyObject]]() //intialised the variable dictionary in which data will be stored and retrieved in the next screen with that particular id.
       var indexDict = [String:AnyObject]()
     var dict = [String:AnyObject]() // intilaised the variable dict
   

    override func viewDidLoad() {
        super.viewDidLoad()
         retrieveData()
        

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionary.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 //height of each cell viewed in table cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        indexDict = dictionary[indexPath.row]
        
        //intialised the each fields where data will be retrieved with particular tags
        
        if let x = cell.viewWithTag(1) as? UILabel
        {
            x.text = indexDict["name"] as? String //name will be stored in variable x with tag value 1
        }
        if let y = cell.viewWithTag(2) as? UILabel
        {
            y.text = indexDict["age"] as? String //age will be stored in variable y with tag value 2
        }
        if let z = cell.viewWithTag(3) as? UILabel
        {
            z.text = indexDict["gender"] as? String //gender will be stored in variable z with tag value 3
        }
        if let a = cell.viewWithTag(4) as? UILabel
        {
            a.text = indexDict["height"] as? String //height will be stored in variable a with tag value 4
        }
        if let b = cell.viewWithTag(5) as? UILabel
        {
            b.text = indexDict["weight"] as? String //weight will be stored in variable b with tag value 5
        }
        if let c = cell.viewWithTag(6) as? UILabel
        {
            c.text = indexDict["bmi"] as? String //bmi will be stored in variable c with tag value 6
        }
        
    
        return cell
    }
    // added the functionality when to select the row, user will move to the next screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexDict = dictionary[indexPath.row]
        self.performSegue(withIdentifier: "edit", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let vc = segue.destination as?  ViewController3
            vc!.dictionary = indexDict
            
        }
    }
    
    //function to retreive the data from the previous screen.
    func retrieveData(){
        
        db = Firestore.firestore()
        db?.collection("data").getDocuments(completion: { (snap, err) in
        
            for i in snap!.documents{
                self.dictionary.append(i.data() as [String : AnyObject])
                self.listTable.reloadData()
            }
            print("dict is",self.dictionary)
            
            
        })
        
    }
    //functionality of the delete button
    @IBAction func Delete(_ sender: UIButton) {
        
        //for loop initialised to delete all the entries from the database when delete button is pressed.
        for i in dictionary{
            print("docid is",i["docId"] as? String)
            
            deleteData(docId: (i["docId"] as? String)!)
        }
    }

    func deleteData(docId:String){
        
        db = Firestore.firestore()
               db?.collection("data").document(docId).delete(){
                   err in
                   if let error = err{
                       print(error.localizedDescription)
                       
                   }else{
                       print("document deleted successfully")
                       
                       let alert = UIAlertController(title: "Message", message: "Successfully Deleted", preferredStyle: .alert)
                       let okay = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.dismiss(animated: true, completion: nil)
                       })
                       alert.addAction(okay)
                       self.present(alert, animated: true, completion: nil)
                    
                     
                   }
              
               }
        
        
    }
    
    
    @IBAction func EditButton(_ sender: UIButton) {
        performSegue(withIdentifier: "edit", sender: nil)
        
    }
}
