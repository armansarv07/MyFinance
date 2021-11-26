//
//  CoreDataCRUDProtocol.swift
//  MyFinance
//
//  Created by Arman on 26.11.2021.
//

import Foundation

protocol CoreDataCRUDProtocol {
    func fetchData(tableViewHandler handler: @escaping () -> ())
    func addData(title: String, category: String, amount: Int64, tableViewHandler handler: @escaping () -> ())
}
