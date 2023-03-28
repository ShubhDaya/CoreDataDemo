//
//  PersonUserListVC.swift
//  CoreDataShubham
//
//  Created by ADMIN on 21/03/23.
//

import UIKit
import Foundation



extension Notification.Name {
    static let refresh = Notification.Name("refresh")
    static let myNotificationName = Notification.Name("EditPersonDataPass")
}

//protocol EditPersonDataPass {
//    func data(object:[String:String], index : Int,isEdit:Bool)
//}

class PersonUserListVC: UIViewController,  UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var tblPersonList: UITableView!
    var arrPerson  = [Person]()
//    var delegate : EditPersonDataPass!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblPersonList.delegate = self
        self.tblPersonList.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.arrPerson = DataBaseManager.sharedInstance.getPersonData()
        self.tblPersonList.reloadData()

    }
    
    @IBAction func btnSkip(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // number of rows in table view
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return arrPerson.count
      }
      
      // create a cell for each table view row
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          // create a new cell if needed or reuse an old one
          let cell = tableView.dequeueReusableCell(withIdentifier: "PersonListCell") as! PersonListCell
          let obj = arrPerson[indexPath.row]
        cell.lblPersonEmail.text =  obj.email
          cell.lblPersonName.text =  obj.name
          cell.btnDelete.tag = indexPath.row
          cell.btnDelete.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)

        return cell
      }
  
    @objc func buttonSelected(sender: UIButton){
        print(sender.tag)
        arrPerson = DataBaseManager.sharedInstance.deletePersonList(index: sender.tag)
        self.tblPersonList.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = arrPerson[indexPath.row]

        let object: [String: Any] = ["name":arrPerson[indexPath.row].name,"email":arrPerson[indexPath.row].email,"password":arrPerson[indexPath.row].password,"i":indexPath.row,"isEditing":true]
        

        let VC = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePersonInfo") as! UpdatePersonInfo
        VC.i = indexPath.row
        VC.UserItem = obj
        self.navigationController?.pushViewController(VC, animated: true)

        }
    //        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
    //        self.navigationController?.pushViewController(VC, animated: true)

   
    func getUserData(){
        
        for person in arrPerson {
        }
        
    }
    
}
