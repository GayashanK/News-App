//
//  Source.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/13/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import Foundation
import ObjectMapper

class Source: NSObject,NSCoding, Mappable {
    
    var id: Int?
    var name: String?
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
    required init?(coder aDecoder: NSCoder){
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id,forKey:"id")
        aCoder.encode(name,forKey:"name")
    }
}
