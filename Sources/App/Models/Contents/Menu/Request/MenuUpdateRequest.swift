//
//  MenuUpdateRequest.swift
//  
//
//  Created by JeongTaek Han on 2023/05/23.
//

import Fluent
import Vapor


struct MenuUpdateRequest: Content {
    
    var targetMenuId: Int
    var categoryId: Int?
    var menuName: String?
    var description: String?
    var price: Double?
    var estimatedPrepTime: Int?
    var imageUrl: String?
    
}
