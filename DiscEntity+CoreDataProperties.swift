//
//  DiscEntity+CoreDataProperties.swift
//  DiscGolfBagManager
//
//  Created by Finley Vickers on 2024-10-13.
//
//

import Foundation
import CoreData


extension DiscEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiscEntity> {
        return NSFetchRequest<DiscEntity>(entityName: "DiscEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var speed: Int16
    @NSManaged public var glide: Int16
    @NSManaged public var turn: Int16
    @NSManaged public var fade: Int16

}

extension DiscEntity : Identifiable {

}
