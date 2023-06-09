//
//  Category.swift
//  
//
//  Created by JeongTaek Han on 2023/05/01.
//

import Fluent
import Vapor

final class Category: Model {
    
    // Name of the table or collection
    static let schema = "restaurant_category"
    
    // Unique identifier for this Category
    @ID(custom: "id", generatedBy: .database)
    var id: Int?
    
    // The MenuItem's category
    @Field(key: "name")
    var name: String
    
    @Children(for: \.$category)
    var menuItems: [MenuItem]
    
    // Creates a new, empty Category
    init() { }
    
    // Creates a new MenuItem with all properties set
    init(id: Int? = nil, category: String) {
        self.id = id
        self.name = category
    }
    
    enum DatabaseKeys: String {
        case id
        case name
    }
    
}
