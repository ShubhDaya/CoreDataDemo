//
//  SignUpVC.swift
//  CoreDataShubham
//
//  Created by ADMIN on 15/03/23.
//

import UIKit
import CoreData

class SignUpVC: UIViewController, UITextFieldDelegate {
   
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    var context = (UIApplication.shared.delegate  as! AppDelegate).persistentContainer.viewContext
    
    var UserItem : [Person]?

    var i = 0
    var isUpdate = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshList(_:)), name: .refresh, object: nil)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
    //    NotificationCenter.default.addObserver(self, selector: #selector(refreshList), name: .refresh, object: nil)

    }
    
  
    
    @objc func refreshList(_ notification: Notification) {
        if let object = notification.userInfo as? [String: Any] {
            
            txtName.text = object["name"] as? String
            txtEmail.text = object["email"] as? String
            txtPassword.text = object["password"] as? String
            i = object["i"] as! Int
            isUpdate = (object["isEditing"] != nil)
//            if let password = object["password"] as? Int {
//                print(password)
//
//            }
//            if let email = object["email"] as? String {
//                print(email)
//            }
       
        }
    }
   

    @objc func handle(_ notification:NSNotification){
        print("my notification called")
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
    
    func fetchData(){
        //fetch the data from core data to disply
        do {
            self.UserItem = try context.fetch(Person.fetchRequest())
            print(self.UserItem?.count)
        }catch{
            
        }
    }
    
    func addData(){
        let dict = ["name":txtName.text ?? "","email":txtEmail.text ?? "","password":txtPassword.text ?? ""]
        
        if isUpdate{
            DataBaseManager.sharedInstance.editPersonData(dict: dict, i: i)
        }else{
            let value = DataBaseManager.sharedInstance.checkEmailAlreadyInData(email: txtEmail.text ?? "")
            
            if value == false {
             
                DataBaseManager.sharedInstance.saveUserRegister(object: dict)
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "PersonUserListVC") as! PersonUserListVC
                self.navigationController?.pushViewController(VC, animated: true)
                
                
            //    self.fetchData()
            }else{
                let alert = UIAlertController(title: "Alert",
                                              message: "User email already exist",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
            }
        }
        
     
        
        self.txtName.text = ""
        self.txtEmail.text = ""
        self.txtPassword.text = ""
        
    }
    
  
    
  }
