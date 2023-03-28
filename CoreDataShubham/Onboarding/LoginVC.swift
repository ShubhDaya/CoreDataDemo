//
//  LoginVC.swift
//  CoreDataShubham
//
//  Created by ADMIN on 21/03/23.
//


import UIKit
import CoreData
import SwiftyJWT
import CryptoKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var context = (UIApplication.shared.delegate  as! AppDelegate).persistentContainer.viewContext
    var User : [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self

        print("Document Directory :", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found")
    }
  
  
    @IBAction func btnLogin(_ sender: Any) {
        if self.txtEmail.text == ""{
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter Email",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            
        }else if self.txtPassword.text == ""{
            let alert = UIAlertController(title: "Alert",
                                          message: "Please Enter Password",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            
        }else{
            let obj =  fetchUserDetails(withEmail: txtEmail.text ?? "")
            
            self.txtEmail.text = ""
            self.txtPassword.text = ""

            if obj != nil{
                print(obj?.email)
                let alert = UIAlertController(title: "Alert",
                                              message: "User Login Succesfully",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
                
            }else{
                let alert = UIAlertController(title: "Alert",
                                              message: "User not found",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
            }
          
        }
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PersonUserListVC") as? PersonUserListVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func btnSignUp(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func fetchUserDetails(withEmail email : String) -> Person?{
        
        let fetchRequest = Person.fetchRequest() as NSFetchRequest<Person>
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do{
            self.User = try context.fetch(fetchRequest)
            return self.User?.first
        }catch{
          
        }
        return nil
    }
}


extension Data {
    func urlSafeBase64EncodedString() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}

