//
//  Category.swift
//  ToDoey
//
//  Created by Chris Gomez on 7/24/18.
//  Copyright © 2018 Chris Gomez. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    let items = List<Item>()
    // ABOVE SAME AS USING SWIFT: var items = Array<Int>(). Code above links Category to the Item.swift
    // MEANING THAT IT ALLOWS THE Category CLASS TO HAVE MULTIPLE Item CLASS OBJECTS. THE APP HAS A CATEGORY
    // WITH ITS OWN UNIQUE SET OF ITEMS.
}
