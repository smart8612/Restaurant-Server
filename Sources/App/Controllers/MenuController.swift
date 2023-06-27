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
        menu.patch("", use: update)
        menu.delete("", use: delete)
    }
    
    func create(req: Request) async throws -> Response {
        let content = try req.content.decode(MenuCreateRequest.self)
        
        let category = try await Category.find(content.categoryId, on: req.db)
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
        
        return req.redirect(to: "menu?category=\(category.name)")
    }
    
    func read(req: Request) async throws -> Response {
        let queryParams = try? req.query.decode(MenuItemReadRequest.self)
        
        let menuItems: [MenuItem]
        
        if let categoryName = queryParams?.category {
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
                category: $0.category,
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
        let content = try req.content.decode(MenuUpdateRequest.self)
        
        let targetMenuItem = try await MenuItem.query(on: req.db).with(\.$category)
            .filter(\.$id == content.targetMenuId)
            .first()
        guard let targetMenuItem = targetMenuItem else {
            throw Abort(.notFound)
        }

        if let category = try? await Category.find(content.categoryId, on: req.db) {
            targetMenuItem.category = category
        }
        
        if let description = content.description {
            targetMenuItem.description = description
        }
        
        if let estimatedPrepTime = content.estimatedPrepTime {
            targetMenuItem.estimatedPrepTime = estimatedPrepTime
        }
        
        if let imageUrl = content.imageUrl {
            targetMenuItem.imageUrl = imageUrl
        }
        
        if let menuName = content.menuName {
            targetMenuItem.name = menuName
        }
        
        if let price = content.price {
            targetMenuItem.price = price
        }
        
        let categoryName = targetMenuItem.category.name
        
        try await targetMenuItem.update(on: req.db)
        
        return req.redirect(to: "menu?category=\(categoryName)")
    }
    
    func delete(req: Request) async throws -> Response {
        let content = try req.content.decode(MenuDeleteRequest.self)
        
        let targetMenuItem = try await MenuItem.query(on: req.db).with(\.$category)
            .filter(\.$id == content.menuId)
            .first()
        guard let targetMenuItem = targetMenuItem else {
            throw Abort(.noContent)
        }
        
        let categoryName = targetMenuItem.category.name
        
        try await targetMenuItem.delete(on: req.db)
        
        return req.redirect(to: "menu?category=\(categoryName)")
    }
    
}

