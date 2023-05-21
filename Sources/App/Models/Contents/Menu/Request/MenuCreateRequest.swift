//
//  MenuCreateRequest.swift
//
//
//  Created by JeongTaek Han on 2023/05/21.
//

import Fluent
import Vapor


struct MenuCreateRequest: Content {
    
    var categoryName: String
    var menuName: String
    var description: String
    var price: Double
    var estimatedPrepTime: Int
    var imageUrl: String
    
}
