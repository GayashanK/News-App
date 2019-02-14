//
//  Publisher.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/14/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import Foundation
import ObjectMapper

class Publisher: NSObject,NSCoding, Mappable {
    
    var id: String?
    var name: String?
    var detail: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        detail <- map["description"]
        url <- map["url"]
        category <- map["category"]
        language <- map["language"]
        country <- map["country"]
    }
    
    required init?(coder aDecoder: NSCoder){
        id = aDecoder.decodeObject(forKey: "id") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        detail = aDecoder.decodeObject(forKey: "description") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
        category = aDecoder.decodeObject(forKey: "category") as? String
        language = aDecoder.decodeObject(forKey: "language") as? String
        country = aDecoder.decodeObject(forKey: "country") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id,forKey:"id")
        aCoder.encode(name,forKey:"name")
        aCoder.encode(detail,forKey:"description")
        aCoder.encode(url,forKey:"url")
        aCoder.encode(category,forKey:"category")
        aCoder.encode(language,forKey:"language")
        aCoder.encode(country,forKey:"country")
        
    }
}

