//
//  ExpensesCellViewModel.swift
//  MyFinance
//
//  Created by Arman on 26.11.2021.
//

import Foundation
 
class ExpensesCellViewModel: ExpensesCellViewModelType {
    private var expense: Expense
    
    var description: String {
        if let title = expense.title, let category = expense.category {
            return "Title: \(title)     Category: \(category)"
        }
        return "Title: nil    Category: nil"
    }
    
    var amount: String {
        return "\(expense.amount)"
    }
    
    init(expense: Expense) {
        self.expense = expense
    }
}
