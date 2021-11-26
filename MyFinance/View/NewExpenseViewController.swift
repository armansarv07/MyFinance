//
//  NewExpenseViewController.swift
//  MyFinance
//
//  Created by Arman on 26.11.2021.
//

import UIKit
import CoreData

enum EditingStyle {
    case edit
    case add
}

class NewExpensesViewController: UIViewController {
    @IBOutlet weak var titleTf: UITextField!
    @IBOutlet weak var categoryTf: UITextField!
    @IBOutlet weak var amountTf: UITextField!
    var currentExpense: Expense!
    var editingStyle: EditingStyle!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEditScreeen()
    }
    

    // MARK: Save to Core Data
    func addData(title: String, category: String, amount: Int64) {
        let expense = Expense(context: context)
        expense.title = title
        expense.category = category
        expense.amount = amount
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func setupEditScreeen() {
        if currentExpense != nil {
            setupNavigationBar()
            titleTf.text = currentExpense.title
            categoryTf.text = currentExpense.category
            amountTf.text = "\(currentExpense.amount)"
        }
    }
    private func setupNavigationBar() {
        self.navigationItem.title = currentExpense.title
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        switch editingStyle {
        case .edit:
            let expense = currentExpense
            expense?.title = titleTf.text
            expense?.category = categoryTf.text
            expense?.amount = Int64(amountTf.text!) ?? 0
            
            do {
                try self.context.save()
            } catch {
                
            }
            dismiss(animated: true, completion: nil)
        case .add:
            guard let title = titleTf.text, let category = categoryTf.text, title != "", category != "" else {return}
            
            if amountTf.text == nil || amountTf.text == "" {
                amountTf.text = "0"
            }
            guard let intVal = Int64(amountTf.text!) else { return }
            addData(title: title, category: category, amount: intVal)
            dismiss(animated: true, completion: nil)
        case .none:
            break
        }
    }
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
