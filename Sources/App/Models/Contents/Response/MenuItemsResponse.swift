//
//  MenuItemsContent.swift
//  
//
//  Created by JeongTaek Han on 2023/05/02.
//

import Fluent
import Vapor


struct MenuItemsResponse: Content {
    
    var items: [MenuItemResponse]
    
    init(menuItems: [MenuItem]) {
        self.items = menuItems.compactMap {
            MenuItemResponse(menuItem: $0)
        }
    }
    
}
