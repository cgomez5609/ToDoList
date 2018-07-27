//
//  ViewController.swift
//  ToDoey
//
//  Created by Chris Gomez on 7/20/18.
//  Copyright © 2018 Chris Gomez. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var itemArray = ["Climb more", "drink water", "drink more water"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
}

