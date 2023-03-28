//
//  Person+CoreDataProperties.swift
//  CoreDataShubham
//
//  Created by ADMIN on 22/03/23.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var familyRelation: NSSet?

}

// MARK: Generated accessors for familyRelation
extension Person {

    @objc(addFamilyRelationObject:)
    @NSManaged public func addToFamilyRelation(_ value: FamilyMember)

    @objc(removeFamilyRelationObject:)
    @NSManaged public func removeFromFamilyRelation(_ value: FamilyMember)

    @objc(addFamilyRelation:)
    @NSManaged public func addToFamilyRelation(_ values: NSSet)

    @objc(removeFamilyRelation:)
    @NSManaged public func removeFromFamilyRelation(_ values: NSSet)

}

extension Person : Identifiable {

}
