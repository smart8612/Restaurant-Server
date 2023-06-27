//
//  CategoryReadResponse.swift
//  
//
//  Created by JeongTaek Han on 2023/05/23.
//


import Fluent
import Vapor


struct CategoryReadResponse: Content {
    
    var id: Int
    var name: String
    
}

