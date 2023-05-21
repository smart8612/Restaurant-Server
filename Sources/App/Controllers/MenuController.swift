//
//  MenuController.swift
//
//
//  Created by JeongTaek Han on 2023/05/21.
//

import Fluent
import Vapor


struct MenuController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let menu = routes.grouped("menu")
        menu.post("", use: create)
        menu.get("", use: read)
        menu.get("", ":category", use: read)
        menu.patch("", use: update)
        menu.delete("", use: delete)
    }
    
    func create(req: Request) async throws -> Response {
        let content = try req.content.decode(MenuCreateRequest.self)
        
        let category = try await Category.query(on: req.db)
            .filter(\.$name == content.categoryName)
            .first()
        
        guard let category = category, let categoryID = category.id else {
            throw Abort(.notFound)
        }
        
        try await MenuItem(
            categoryID: categoryID,
            name: content.menuName,
            description: content.description,
            price: content.price,
            imageUrl: content.imageUrl,
            estimatedPrepTime: content.estimatedPrepTime
        ).create(on: req.db)
        
        return req.redirect(to: "menu/\(category.name)")
    }
    
    func read(req: Request) async throws -> Response {
        let categoryName = req.parameters.get("category")
        
        let menuItems: [MenuItem]
        
        if let categoryName = categoryName {
            let category = try await Category.query(on: req.db)
                .filter(\.$name == categoryName)
                .with(\.$menuItems) { $0.with(\.$category) }
                .first()
            menuItems = category?.menuItems ?? []
        } else {
            menuItems = try await MenuItem.query(on: req.db)
                .with(\.$category)
                .all()
        }
        
        let menuItemResponse = try menuItems.map {
            MenuItemResponse(
                category: $0.category.name,
                id: try $0.requireID(),
                image_url: $0.imageUrl,
                name: $0.name,
                description: $0.description,
                price: $0.price
            )
        }
        
        let result = MenuItemsReadResponse(items: menuItemResponse)
        return try await result.encodeResponse(for: req)
    }
    
    func update(req: Request) async throws -> Response {
        let content = try req.content.decode(CategoryUpdateRequest.self)
        
        let targetCategory = try await Category.query(on: req.db)
            .filter(\.$name == content.targetCategoryName)
            .first()
        
        guard let targetCategory = targetCategory else {
            throw Abort(.notFound)
        }

        targetCategory.name = content.changedCategoryName
        try await targetCategory.update(on: req.db)
        
        return req.redirect(to: "categories")
    }
    
    func delete(req: Request) async throws -> Response {
        let content = try req.content.decode(MenuDeleteRequest.self)
        
        let targetMenuItem = try await MenuItem.find(content.menuId, on: req.db)
        guard let targetMenuItem = targetMenuItem else {
            throw Abort(.noContent)
        }
        
        let categoryName = targetMenuItem.$name.value ?? ""
        
        try await targetMenuItem.delete(on: req.db)
        
        return req.redirect(to: "categories/\(categoryName)")
    }
    
}

