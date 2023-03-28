//
//  FamilyMember+CoreDataProperties.swift
//  CoreDataShubham
//
//  Created by ADMIN on 22/03/23.
//
//

import Foundation
import CoreData


extension FamilyMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FamilyMember> {
        return NSFetchRequest<FamilyMember>(entityName: "FamilyMember")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var relation: String?
    @NSManaged public var person: Person?

}

extension FamilyMember : Identifiable {

}
