//
//  Income+CoreDataProperties.swift
//  MyFinance
//
//  Created by Arman on 26.11.2021.
//
//

import Foundation
import CoreData


extension Income {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Income> {
        return NSFetchRequest<Income>(entityName: "Income")
    }

    @NSManaged public var title: String?
    @NSManaged public var amount: Int64
    @NSManaged public var category: String?

}

extension Income : Identifiable {

}
