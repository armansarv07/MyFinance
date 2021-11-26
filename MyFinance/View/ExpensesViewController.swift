//
//  ExpensesViewController.swift
//  MyFinance
//
//  Created by Arman on 26.11.2021.
//

import UIKit
import CoreData

class ExpensesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var overallMoney: UILabel!
    
    
    private var viewModel: ExpensesViewModel?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel = ExpensesViewModel()
        
        viewModel?.fetchData {
            self.tableView.reloadData()
        }
    }
    
    func ownFetch() {
        viewModel?.fetchData {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.fetchData {
            self.tableView.reloadData()
        }
    }
    
}

extension ExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpensesCell", for: indexPath) as? ExpensesCellView
        
        guard let tableViewCell = cell,
              let viewModel = viewModel else { return UITableViewCell()}
        tableViewCell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            // TODO: delete from viewModel implemetation
            self.viewModel?.removeData(atIndexPath: indexPath) {
                self.tableView.reloadData()
            }
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditExpense" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let expense = self.viewModel?.expenses?[indexPath.row]
            let newExpense = segue.destination as! NewExpensesViewController
            newExpense.currentExpense = expense
            newExpense.editingStyle = .edit
        }
        if segue.identifier == "NewExpense" {
            let newExpense = segue.destination as! NewExpensesViewController
            newExpense.editingStyle = .add
        }
    }
}
