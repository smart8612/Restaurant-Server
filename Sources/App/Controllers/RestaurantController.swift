import Fluent
import Vapor

struct RestaurantController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        try routes.register(collection: CategoriesController())
        try routes.register(collection: MenuController())
        routes.post("order", use: order)
        routes.get("images", ":name", use: images)
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
        let filePath = "/app/Public/Images/\(fileName)"

        // Read the image file data from disk
        guard let fileData = try? await req.fileio.collectFile(at: filePath) else {
            throw Abort(.notFound)
        }
        
        // Create a Vapor response with the image data
        let response = Response(
            status: .ok,
            headers: HTTPHeaders([("Content-Type", "image/jpeg")]),
            body: Response.Body(buffer: fileData)
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
