//
//  WebServiceResponse.swift
//  POS
//
//  Created by Kasun Gayashan on 8/30/18.
//  Copyright © 2018 cis4. All rights reserved.
//

import Foundation
import ObjectMapper

class ArticleResponse: Mappable {
    var status: String?
    var articles: [Article]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        articles <- map["articles"]
    }
}

class PublisherResponse: Mappable {
    var status: String?
    var publishers: [Publisher]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        publishers <- map["sources"]
    }
}
