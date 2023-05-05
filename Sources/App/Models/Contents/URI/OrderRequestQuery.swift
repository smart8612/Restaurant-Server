//
//  OrderRequestQuery.swift
//  
//
//  Created by JeongTaek Han on 2023/05/03.
//

import Fluent
import Vapor

struct OrderRequestQuery: Content {
    
    var menuIds: [Int]?
    
}
