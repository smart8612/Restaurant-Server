import Fluent

struct CreateCategory: AsyncMigration {
    
    // Prepares the database for storing MenuItem models
    func prepare(on database: Database) async throws {
        try await database.schema(Category.schema)
            .field("id", .int, .identifier(auto: true))
            .field("name", .string, .required)
            .create()
        
        try await [
            Category(category: "appetizers"),
            Category(category: "salads"),
            Category(category: "soups"),
            Category(category: "entrees"),
            Category(category: "desserts"),
            Category(category: "sandwiches")
        ].create(on: database)
    }
    
    // Optionally reverts the changes made in the prepare method
    func revert(on database: Database) async throws {
        try await database.schema(Category.schema).delete()
    }
    
}
