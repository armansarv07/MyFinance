//
//  Expense+CoreDataProperties.swift
//  MyFinance
//
//  Created by Arman on 26.11.2021.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var title: String?
    @NSManaged public var amount: Int64
    @NSManaged public var category: String?

}

extension Expense : Identifiable {

}
