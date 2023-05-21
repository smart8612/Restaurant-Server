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
    
    init?(menuItem: MenuItem) {
        do {
            self.category = menuItem.$category.name
            self.id = try menuItem.requireID()
            self.image_url = menuItem.imageUrl
            self.name = menuItem.name
            self.description = menuItem.description
            self.price = menuItem.price
        } catch {
            return nil
        }
    }
    
}
