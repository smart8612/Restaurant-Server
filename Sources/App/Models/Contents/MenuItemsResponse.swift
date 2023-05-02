//
//  MenuItemsContent.swift
//  
//
//  Created by JeongTaek Han on 2023/05/02.
//

import Fluent
import Vapor


struct MenuItemsResponse: Content {
    
    var items: [MenuItemContent]
    
    init(menuItems: [MenuItem]) {
        self.items = menuItems.compactMap {
            MenuItemContent(menuItem: $0)
        }
    }
    
    struct MenuItemContent: Content {
        
        var category: String
        var id: Int
        var image_url: String
        var name: String
        var description: String
        var price: Double
        
        init?(menuItem: MenuItem) {
            do {
                self.category = menuItem.category.category
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
    
}
