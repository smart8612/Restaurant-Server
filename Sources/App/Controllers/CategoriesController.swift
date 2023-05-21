//
//  CategoriesController.swift
//  
//
//  Created by JeongTaek Han on 2023/05/21.
//

import Fluent
import Vapor


struct CategoriesController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let categories = routes.grouped("categories")
        categories.post("", use: create)
        categories.get("", use: read)
    }
    
    func create(req: Request) async throws -> Response {
        let content = try req.content.decode(CategoryCreateRequest.self)
        
        guard let name = content.categoryName else {
            throw Abort(.badRequest)
        }
        
        try await Category(category: name).create(on: req.db)
        
        return req.redirect(to: "categories")
    }
    
    func read(req: Request) async throws -> Response {
        let categories = try await Category.query(on: req.db).all()
        let result = CategoriesReadResponse(categories: categories)
        return try await result.encodeResponse(for: req)
    }
    
//    func delete(req: Request) async throws -> HTTPStatus {
//        guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
//            throw Abort(.notFound)
//        }
//        try await todo.delete(on: req.db)
//        return .noContent
//    }
    
}

