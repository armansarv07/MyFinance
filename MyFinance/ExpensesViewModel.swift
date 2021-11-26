//
//  ExpensesViewModel.swift
//  MyFinance
//
//  Created by Arman on 26.11.2021.
//

import Foundation
import UIKit
import CoreData

class ExpensesViewModel: ExpensesViewModelType, CoreDataCRUDProtocol {
    
    
    // MARK: For Table View
    var expenses: [Expense]?
    
    var selectedRow: IndexPath?
    
    func numberOfRows() -> Int {
        return expenses?.count ?? 0
    }
    
    
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ExpensesCellViewModelType? {
        guard let expense = expenses?[indexPath.row] else { return nil }
        return ExpensesCellViewModel(expense: expense)
    }
    
    // MARK: For Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchData(tableViewHandler handler: @escaping () -> ()) {
        do {
            let request = Expense.fetchRequest() as NSFetchRequest<Expense>
            self.expenses = try context.fetch(request)
            DispatchQueue.main.async {
                handler()
            }
        } catch {
            
        }
        
    }
    
    func addData(title: String, category: String, amount: Int64, tableViewHandler handler: @escaping () -> ()) {
        let expense = Expense(context: context)
        expense.title = title
        expense.category = category
        expense.amount = amount
        
        do {
            try context.save()
        } catch {
            
        }
        fetchData {
            handler()
        }
    }
    
    func removeData(atIndexPath indexPath: IndexPath, tableViewHandler handler: @escaping () -> ()) {
        let expenseToRemove = expenses![indexPath.row]
        
        self.context.delete(expenseToRemove)
        do {
            try context.save()
        } catch {
            
        }
        fetchData {
            handler()
        }
    }
    
    func updateData(atIndexPath indexPath: IndexPath, newTitle title: String, newCategory category: String, newAmount amount: Int64, tableViewHandler handler: @escaping () -> ()) {
        let expense = self.expenses![indexPath.row]
        
        expense.title = title
        expense.category = category
        expense.amount = amount
        
        do {
            try context.save()
        } catch {
            
        }
        fetchData {
            handler()
        }
    }
    
}
