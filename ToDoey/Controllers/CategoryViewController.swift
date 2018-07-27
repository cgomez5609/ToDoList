//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Chris Gomez on 7/24/18.
//  Copyright © 2018 Chris Gomez. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController: UITableViewController {
    let realm = try! Realm()
    var category : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.rowHeight = 80.0
        tableView.separatorColor = .none

    }

    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            
            self.save(categoryNamed: newCategory)
            self.tableView.reloadData()
        }
        alert.addTextField { (field) in
            field.placeholder = "Add new category"
            textField = field
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)  // used to present pop up screen to add new category
    }
    
    // MARK - Table view datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.text = category?[indexPath.row].name ?? "No nategories added yet"
        cell.backgroundColor = UIColor(hexString: category?[indexPath.row].color ?? "BDD4FF")
        cell.delegate = self
        
        return cell
    }
    
    // MARK - Tableview delegagte methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = category?[indexPath.row] 
        }
    }
    
    func save(categoryNamed category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        // SET categoryData PROPERTY TO LOOK INSIDE REALM AND FETCH ALL OF THE OBJECTS WITH THE Category DATATYPE.
        category = realm.objects(Category.self)
        tableView.reloadData()
    }
    
}

// MARK - Swipe cell delegage methods

extension CategoryViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            if let categorytoBeDeleted = self.category?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(categorytoBeDeleted)
                    }
                } catch {
                    print("error deleting category \(error)")
                }
            }
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}
