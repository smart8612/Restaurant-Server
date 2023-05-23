//
//  CategoryUpdateRequest.swift
//  
//
//  Created by JeongTaek Han on 2023/05/21.
//

import Fluent
import Vapor


struct CategoryUpdateRequest: Content {
    
    var targetCategoryId: Int
    var changedCategoryName: String
    
}
