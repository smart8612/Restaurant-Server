import Fluent
import Vapor

struct RestaurantController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        try routes.register(collection: CategoriesController())
        routes.get("menu", use: menu)
        routes.post("order", use: order)
        routes.get("images", ":name", use: images)
    }
    
    func menu(req: Request) async throws -> Response {
        let menuItems: [MenuItem]
        
        if let categoryName = try? req.query.decode(MenuItemRequestQuery.self).category {
            let category = try await Category.query(on: req.db)
                .filter(\.$name == categoryName)
                .with(\.$menuItems)
                .first()
            menuItems = category?.menuItems ?? []
        } else {
            menuItems = try await MenuItem.query(on: req.db).all()
        }
        
        let result = MenuItemsResponse(menuItems: menuItems)
        return try await result.encodeResponse(for: req)
    }
    
    func order(req: Request) async throws -> [String: Int] {
        var preperationTime = 1
        
        guard let menuIds = try? req.content.decode(OrderRequestQuery.self).menuIds else {
            throw Abort(.notFound)
        }
        
        let menuItems = try await MenuItem.query(on: req.db).all()
        
        preperationTime = menuIds
            .compactMap { id in
                menuItems.filter { item in (try? item.requireID() == id) ?? false }.first
            }
            .reduce(preperationTime) { $0 + $1.estimatedPrepTime }
        
        return ["preparation_time": preperationTime]
    }
    
    func images(req: Request) async throws -> Response {
        let fileName = req.parameters.get("name") ?? ""
        
        // Get the file path of the image you want to return
        let filePath = "\(req.application.directory.publicDirectory)images/\(fileName)"
        
        print(filePath)

        // Read the image file data from disk
        guard let fileData = FileManager.default.contents(atPath: filePath) else {
            throw Abort(.notFound)
        }

        // Create a Vapor response with the image data
        let response = Response(
            status: .ok,
            headers: HTTPHeaders([("Content-Type", "image/jpeg")]),
            body: Response.Body(data: fileData)
        )

        return response
        
    }


//    func create(req: Request) async throws -> Todo {
//        let todo = try req.content.decode(Todo.self)
//        try await todo.save(on: req.db)
//        return todo
//    }
//
//    func delete(req: Request) async throws -> HTTPStatus {
//        guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
//            throw Abort(.notFound)
//        }
//        try await todo.delete(on: req.db)
//        return .noContent
//    }
    
}
