//
//  Item.swift
//  ToDoey
//
//  Created by Chris Gomez on 7/24/18.
//  Copyright © 2018 Chris Gomez. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var dateCreated : Date?
    // this is used to link to Category to Item. Check Item.swift for code relating to this
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    // ABOVE WE CREATED A VARIABLE THAT LINKS IT BACK TO THE Category OBJECT. THE PROPERTY NAME IS THE SAME AS OUR
    // VARIABLE IN OUR Category CLASS
}
