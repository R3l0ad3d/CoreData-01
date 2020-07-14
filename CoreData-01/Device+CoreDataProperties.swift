//
//  Device+CoreDataProperties.swift
//  CoreData-01
//
//  Created by Joy Reloaded on 14/7/20.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var device: String?
    @NSManaged public var owner: User?

}
