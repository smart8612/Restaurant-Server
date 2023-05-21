//
//  CategoryDeleteRequest.swift
//
//
//  Created by JeongTaek Han on 2023/05/21.
//

import Fluent
import Vapor


struct CategoryDeleteRequest: Content {
    
    var targetCategoryName: String
    
}
