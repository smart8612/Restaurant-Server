import Fluent
import Vapor

final class MenuItem: Model, Content {
    
    // Name of the table or collection
    static let schema = "restaurant"
    
    // Unique identifier for this MenuItem
    @ID(custom: .id)
    var id: Int?
    
    // Parent Relation
    @Parent(key: "category_id")
    var category: Category
    
    // The MenuItem's title
    @Field(key: "title")
    var title: String
    
    // The MenuItem's name
    @Field(key: "name")
    var name: String
    
    // The MenuItem's description
    @Field(key: "description")
    var description: String
    
    // The MenuItem's price
    @Field(key: "price")
    var price: Double
    
    // The MenuItem's image url
    @Field(key: "image_url")
    var imageUrl: URL
    
    // Creates a new, empty MenuItem
    init() { }
    
    // Creates a new MenuItem with all properties set
    init(id: Int? = nil, categoryID: Category.IDValue,
         title: String, name: String, description: String,
         price: Double, imageUrl: URL) {
        self.id = id
        self.title = title
        self.name = name
        self.description = description
        self.price = price
        self.$category.id = categoryID
        self.imageUrl = imageUrl
    }
    
}
