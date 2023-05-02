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
            .field("id", .int, .identifier(auto: true))
            .field("category_id", .int, .required, .references(Category.schema, "id"))
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("price", .double, .required)
            .field("estimated_prep_time", .int, .required)
            .field("image_url", .string, .required)
            .create()
        
        try await [
            MenuItem(categoryID: 4, name: "Spaghetti and Meatballs", description: "Seasoned meatballs on top of freshly-made spaghetti. Served with a robust tomato sauce.", price: 9.0, imageUrl: "#", estimatedPrepTime: 20),
            MenuItem(categoryID: 4, name: "Margherita Pizza", description: "Tomato sauce, fresh mozzarella, basil, and extra-virgin olive oil.", price: 10.0, imageUrl: "#", estimatedPrepTime: 30),
            MenuItem(categoryID: 4, name: "Grilled Steelhead Trout", description: "Pacific steelhead trout with lettuce, tomato, and red onion.", price: 12.75, imageUrl: "#", estimatedPrepTime: 15),
            MenuItem(categoryID: 1, name: "Ham and mushroom ravioli", description: "House-made ravioli filled with pine nuts, parmesan, ham, and mushrooms. Served over tomato sauce.", price: 8.0, imageUrl: "#", estimatedPrepTime: 12),
            MenuItem(categoryID: 3, name: "Chicken Noodle Soup", description: "Chicken simmered alongside yellow onions, carrots, celery, and bay leaves.", price: 3.5, imageUrl: "#", estimatedPrepTime: 5),
            MenuItem(categoryID: 2, name: "Italian Salad", description: "Garlic, red onions, tomatoes, mushrooms, and olives on top of romaine lettuce.", price: 5.0, imageUrl: "#", estimatedPrepTime: 5),
        ].create(on: database)
    }
    
    // Optionally reverts the changes made in the prepare method
    func revert(on database: Database) async throws {
        try await database.schema(MenuItem.schema)
            .delete()
    }
    
}
