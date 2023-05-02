import Fluent
import Vapor

final class MenuItem: Model, Content {
    
    // Name of the table or collection
    static let schema = "restaurant_menuItem"
    
    // Unique identifier for this MenuItem
    @ID(custom: "id", generatedBy: .database)
    var id: Int?
    
    // Parent Relation
    @Parent(key: "category_id")
    var category: Category
    
    // The MenuItem's name
    @Field(key: "name")
    var name: String
    
    // The MenuItem's description
    @Field(key: "description")
    var description: String
    
    // The MenuItem's price
    @Field(key: "price")
    var price: Double
    
    @Field(key: "estimated_prep_time")
    var estimatedPrepTime: Int
    
    // The MenuItem's image url
    @Field(key: "image_url")
    var imageUrl: String
    
    // Creates a new, empty MenuItem
    init() { }
    
    // Creates a new MenuItem with all properties set
    init(id: Int? = nil, categoryID: Category.IDValue,
         name: String, description: String, price: Double, imageUrl: String, estimatedPrepTime: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.$category.id = categoryID
        self.imageUrl = imageUrl
        self.estimatedPrepTime = estimatedPrepTime
    }
    
}
