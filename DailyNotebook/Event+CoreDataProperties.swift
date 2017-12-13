//
//  Event+CoreDataProperties.swift
//  DailyNotebook
//
//  Created by  on 12/4/17.
//  Copyright © 2017 Leems Games. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var notes: String?
    @NSManaged public var image: NSData?

}
