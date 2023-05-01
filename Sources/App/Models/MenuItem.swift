import Fluent
import Vapor

final class MenuItem: Model, Content {
    
    // Name of the table or collection
    static let schema = "restaurant"
    
    // Unique identifier for this MenuItem
    @ID(custom: .id)
    var id: Int?
    
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
    
    // The MenuItem's category
    @Field(key: "category")
    var category: String
    
    // The MenuItem's image url
    @Field(key: "image_url")
    var image_url: URL
    
    // Creates a new, empty MenuItem
    init() { }
    
    // Creates a new MenuItem with all properties set
    init(id: Int? = nil, title: String, name: String, description: String,
         price: Double, category: String, image_url: URL) {
        self.id = id
        self.title = title
        self.name = name
        self.description = description
        self.price = price
        self.category = category
        self.image_url = image_url
    }
    
}
