//
//  ViewController.swift
//  TodoList
//
//  Created by Omara on 20.10.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var todosTV: UITableView!
    var todos: Results<TodoItem>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        getAllTodos()
    }

    private func getAllTodos() {
        
        do {
            let realm = try Realm()
            todos = realm.objects(TodoItem.self)
            todosTV.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
   

}


extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return todos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Avenir", size: 25)
        cell.textLabel?.text = todos?[indexPath.section].title
        
        return cell
    }
    
    
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  section == 0 ? 0 : 15
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        
        return UISwipeActionsConfiguration(actions: [deleteSwipeAction(index: indexPath.section)])
    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, closeAction) in
//            do {
//                let realm = try Realm()
//                try realm.write({
//                    realm.delete(self.todos![indexPath.section])
//                })
//            } catch {
//                
//            }
//        }
//        return UISwipeActionsConfiguration(actions: [deleteAction,deleteAction])
//    }
    
    private func deleteSwipeAction(index: Int) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete", handler: { (_, _, closeAction) in
            //TODO: - delete item whos index = index from realmfile
            do {
                let realm = try Realm()
                try realm.write({
                    realm.delete(self.todos![index])
                })
            } catch let error {
                print(error.localizedDescription)
            }
            
            closeAction(true)
        })
    }
    
}
