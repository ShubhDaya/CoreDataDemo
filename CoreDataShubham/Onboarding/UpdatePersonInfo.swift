//
//  UpdatePersonInfo.swift
//  CoreDataShubham
//
//  Created by ADMIN on 21/03/23.

import UIKit
import CoreData

class UpdatePersonInfo: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblMemberCoubnt: UILabel!

    var context = (UIApplication.shared.delegate  as! AppDelegate).persistentContainer.viewContext
    var UserItem : Person?
    var i = 0
    var isUpdate = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtName.text = UserItem?.name
        self.txtEmail.text = UserItem?.email
        self.txtPassword.text = UserItem?.password
        
        self.lblMemberCoubnt.text = "Count -\(String(describing: UserItem?.familyRelation?.count ?? 0))"
     
        self.txtName.delegate = self
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        // Do any additional setup after loading the view.
    }
  
    
    @IBAction func btnCreateAccount(_ sender: Any) {
        if txtName.text == ""{
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter Name",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }else if txtEmail.text == ""{
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter Email",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return

        }else if txtPassword.text == "" {
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter Password",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return

        }else{
            self.addData()
        }
    }
    
    @IBAction func btnBackToLogin(_ sender: Any) {
    //        let object: [String: Any] = ["id": 1, "email": "abc@def.com"]
    //        NotificationCenter.default.post(name: .refresh, object: object)
          self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func btnNavigateToFamilyMemberVC(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddMemberVC") as? AddMemberVC
        vc?.person = UserItem
        self.navigationController?.pushViewController(vc!, animated: true)    }
    
   
    
    func addData(){
        let dict = ["name":txtName.text ?? "","email":txtEmail.text ?? "","password":txtPassword.text ?? ""]
        
        DataBaseManager.sharedInstance.editPersonData(dict: dict, i: i)
     
        self.txtName.text = ""
        self.txtEmail.text = ""
        self.txtPassword.text = ""
     }
  }
