//File Name: Viewcontroller.swift
//Author Name: Garima Prasher
//student id: 301093329
//DATE : 11 Dec 2019

import UIKit
import Firebase

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listTable: UITableView!
    var db:Firestore?
    var arr = ["sdada","dasdasd"]
       var dictionary = [[String:AnyObject]]()
       var indexDict = [String:AnyObject]()
     var dict = [String:AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
         retrieveData()
        

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionary.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        indexDict = dictionary[indexPath.row]
        
        if let x = cell.viewWithTag(1) as? UILabel{
            x.text = indexDict["name"] as? String
        }
        if let y = cell.viewWithTag(2) as? UILabel{
            y.text = indexDict["age"] as? String
        }
        if let z = cell.viewWithTag(3) as? UILabel{
            z.text = indexDict["gender"] as? String
        }
        if let a = cell.viewWithTag(4) as? UILabel{
            a.text = indexDict["height"] as? String
        }
        if let b = cell.viewWithTag(5) as? UILabel{
            b.text = indexDict["weight"] as? String
        }
        if let c = cell.viewWithTag(6) as? UILabel{
            c.text = indexDict["bmi"] as? String
        }
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexDict = dictionary[indexPath.row]
        self.performSegue(withIdentifier: "data", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "data"{
            let vc = segue.destination as?  ViewController2
            vc!.dictionary = [indexDict]
            
        }
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
    
    @IBAction func Delete(_ sender: UIButton) {
        db = Firestore.firestore()
        db?.collection("data").document((dict["docId"] as? String)!).delete(){
            err in
            if let error = err{
                print(error.localizedDescription)
                
            }else{
                print("document deleted successfully")
                
                let alert = UIAlertController(title: "Message", message: "Successfully Deleted", preferredStyle: .alert)
                let okay = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(okay)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
