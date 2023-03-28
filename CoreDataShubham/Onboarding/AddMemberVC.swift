//
//  AddMemberVC.swift
//  CoreDataShubham
//
//  Created by ADMIN on 22/03/23.
//

import UIKit

class AddMemberVC: UIViewController {

    @IBOutlet weak var txtMemberName: UITextField!
    @IBOutlet weak var txtMemberEmail: UITextField!
    @IBOutlet weak var txtMemberRelation: UITextField!
    var context = (UIApplication.shared.delegate  as! AppDelegate).persistentContainer.viewContext

    var person : Person?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveMemberInfo(_ sender: Any) {
        if txtMemberName.text == ""{
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter Name",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }else if txtMemberEmail.text == ""{
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter Email",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return

        }else if txtMemberRelation.text == "" {
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter Relation",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return

        }else{
            self.saveMemberInfo()
        }
    }

    
    func saveMemberInfo(){
        
        let dict = ["name":txtMemberName.text ?? "","email":txtMemberEmail.text ?? "","relation":txtMemberRelation.text ?? ""]
        
        guard let personobj = person else{
            return
        }
        DataBaseManager.sharedInstance.savePersonFamilyMember(object: dict, person: personobj)
        
        self.txtMemberName.text = ""
        self.txtMemberEmail.text = ""
        self.txtMemberRelation.text = ""


    }
    
}
