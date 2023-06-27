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
        categories.patch("", use: update)
        categories.delete("", use: delete)
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
        
        let categoriesResponse = try categories.map { category in
            CategoryReadResponse(
                id: try category.requireID(),
                name: category.name
            )
        }
        
        let result = CategoriesReadResponse(categories: categoriesResponse)
        return try await result.encodeResponse(for: req)
    }
    
    func update(req: Request) async throws -> Response {
        let content = try req.content.decode(CategoryUpdateRequest.self)
        
        let targetCategory = try await Category.find(content.targetCategoryId, on: req.db)
        guard let targetCategory = targetCategory else {
            throw Abort(.notFound)
        }

        targetCategory.name = content.changedCategoryName
        try await targetCategory.update(on: req.db)
        
        return req.redirect(to: "categories")
    }
    
    func delete(req: Request) async throws -> Response {
        let content = try req.content.decode(CategoryDeleteRequest.self)
        
        let targetCategory = try await Category.find(content.targetCategoryId, on: req.db)
        guard let targetCategory = targetCategory else {
            throw Abort(.notFound)
        }
        
        try await targetCategory.delete(on: req.db)
        
        return req.redirect(to: "categories")
    }
    
}

