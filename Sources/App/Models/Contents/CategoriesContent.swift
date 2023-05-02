//
//  CategoriesContent.swift
//  
//
//  Created by JeongTaek Han on 2023/05/02.
//

import Fluent
import Vapor

struct CategoriesResponse: Content {
    
    var categories: [String]
    
    init(categories: [Category]) {
        self.categories = categories.map { category in
            category.category
        }
    }
    
}
