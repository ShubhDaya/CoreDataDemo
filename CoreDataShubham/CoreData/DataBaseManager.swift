//  DataBaseManager.swift
//  CoreDataShubham
//  Created by ADMIN on 20/03/23.


import Foundation
import CoreData
import UIKit


class DataBaseManager {
    
    static var sharedInstance = DataBaseManager()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    func saveUserRegister(object : [String:String]){
        
        //TODO: Create a person object

        let Person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context!) as! Person
        Person.name = object["name"]
        Person.email = object["email"]
        Person.password = object["password"]
        
        //save the data
        do {
            try context?.save()
        }catch{
            print("data is not save")
        }
        
    }
    
    
    
    
    func checkEmailAlreadyInData(email : String) -> Bool{
      
        let fetchRequest = Person.fetchRequest() as NSFetchRequest<Person>
        
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do{
            let obj = try context?.fetch(fetchRequest)
          
            if obj!.count > 0 {
                return true

            }else{
                return false

            }
            print(obj!.count)
        }catch{
          
        }
        return false
    }
    
    
    func getPersonData() -> [Person]{
        
        var person = [Person]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            person = try context?.fetch(fetchRequest) as! [Person]
        }catch{
            print("Not Found")
        }
        return person
        
    }
    
    func deletePersonList(index:Int)-> [Person]{
        var person = getPersonData()
        
        context?.delete(person[index])
        person.remove(at: index)
        
        do {
            try context?.save()
        }catch{
            print("Can not delete data")
        }
        
        return person
    }
    
    func editPersonData(dict:[String:String],i:Int){
        var person = getPersonData()
        
        person[i].email = dict["email"]
        person[i].name = dict["name"]
        person[i].password = dict["password"]
        
        do{
            try context?.save()
        }catch{
           print("data is not valid")
        }

    }
    
    
    func savePersonFamilyMember(object : [String:String],person:Person){
        
        //TODO: Create a person object

        let Person = NSEntityDescription.insertNewObject(forEntityName: "FamilyMember", into: context!) as! FamilyMember
        Person.name = object["name"]
        Person.email = object["email"]
        Person.relation = object["relation"]
        Person.person = person
        
        //save the data
        do {
            try context?.save()
        }catch{
            print("data is not save")
        }
        
    }
}
