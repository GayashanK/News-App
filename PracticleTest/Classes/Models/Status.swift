//
//  Status.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/13/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import Foundation
import ObjectMapper

class Status: NSObject,NSCoding, Mappable {
    
    var code: Int?
    var description_: String?
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        description_ <- map["description"]
    }
    
    required init?(coder aDecoder: NSCoder){
        code = aDecoder.decodeObject(forKey: "code") as? Int
        description_ = aDecoder.decodeObject(forKey: "description") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(code,forKey:"code")
        aCoder.encode(description_,forKey:"description")
    }
}
