import Fluent

struct CreateCategory: AsyncMigration {
    
    // Prepares the database for storing MenuItem models
    func prepare(on database: Database) async throws {
        try await database.schema(Category.schema)
            .id()
            .field("category", .string, .required)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method
    func revert(on database: Database) async throws {
        try await database.schema(Category.schema)
            .delete()
    }
    
}
