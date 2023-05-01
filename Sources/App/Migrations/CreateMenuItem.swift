//
//  CreateMenuItem.swift
//  
//
//  Created by JeongTaek Han on 2023/05/01.
//

import Fluent

struct CreateMenuItem: AsyncMigration {
    
    // Prepares the database for storing MenuItem models
    func prepare(on database: Database) async throws {
        try await database.schema(MenuItem.schema)
            .id()
            .field("category_id", .int, .required)
            .field("title", .string, .required)
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("price", .string, .required)
            .field("image_url", .string, .required)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method
    func revert(on database: Database) async throws {
        try await database.schema(MenuItem.schema)
            .delete()
    }
    
}
