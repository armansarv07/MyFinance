//
//  ExpensesViewModelType.swift
//  MyFinance
//
//  Created by Arman on 26.11.2021.
//

import Foundation

protocol ExpensesViewModelType {
    var selectedRow: IndexPath? { get }
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ExpensesCellViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
}
