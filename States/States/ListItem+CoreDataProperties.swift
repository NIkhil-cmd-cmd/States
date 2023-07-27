//
//  ListItem+CoreDataProperties.swift
//  States
//
//  Created by Nikhil Krishnaswamy on 6/7/23.
//
//

import Foundation
import CoreData


extension ListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListItem> {
        return NSFetchRequest<ListItem>(entityName: "ListItem")
    }

    @NSManaged public var abbreviation: String?
    @NSManaged public var area: String?
    @NSManaged public var capitalCity: String?
    @NSManaged public var flagImageName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var population: String?
    @NSManaged public var stateSealImageName: String?
    @NSManaged public var largestCity: String?

}

extension ListItem : Identifiable {

}
