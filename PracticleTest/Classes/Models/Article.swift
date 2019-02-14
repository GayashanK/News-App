//
//  Status.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/13/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import Foundation
import ObjectMapper

class Article: NSObject,NSCoding, Mappable {
    
    var source: Source?
    var author: String?
    var title: String?
    var detail: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    
    override init() {
        
    }

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        source <- map["source"]
        author <- map["author"]
        title <- map["title"]
        detail <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
        content <- map["content"]
    }
    
    required init?(coder aDecoder: NSCoder){
        source = aDecoder.decodeObject(forKey: "source") as? Source
        author = aDecoder.decodeObject(forKey: "author") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        detail = aDecoder.decodeObject(forKey: "description") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
        urlToImage = aDecoder.decodeObject(forKey: "urlToImage") as? String
        publishedAt = aDecoder.decodeObject(forKey: "publishedAt") as? String
        content = aDecoder.decodeObject(forKey: "content") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(source,forKey:"source")
        aCoder.encode(author,forKey:"author")
        aCoder.encode(title,forKey:"title")
        aCoder.encode(detail,forKey:"description")
        aCoder.encode(url,forKey:"url")
        aCoder.encode(urlToImage,forKey:"urlToImage")
        aCoder.encode(publishedAt,forKey:"publishedAt")
        aCoder.encode(content,forKey:"content")
        
    }
}
