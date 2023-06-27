//
//  MenuItemsReadResponse.swift
//  
//
//  Created by JeongTaek Han on 2023/05/02.
//

import Fluent
import Vapor


struct MenuItemsReadResponse: Content {
    
    var items: [MenuItemResponse]
    
}
