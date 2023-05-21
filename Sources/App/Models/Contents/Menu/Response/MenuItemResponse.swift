//
//  MenuItemResponse.swift
//  
//
//  Created by JeongTaek Han on 2023/05/20.
//

import Fluent
import Vapor


struct MenuItemResponse: Content {
    
    var category: String
    var id: Int
    var image_url: String
    var name: String
    var description: String
    var price: Double
    
}
