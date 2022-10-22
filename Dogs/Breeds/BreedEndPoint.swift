//
//  BreedEndPoint.swift
//  Dogs
//
//  Created by Przemek on 21/10/2022.
//

import Foundation

struct BreedEndPoint: Endpoint {
    var header: [String: String]?
    
    var body: [String: String]?
    
    var path: String {
        return "/api/breeds/list/all"
    }
    
    var method: RequestMethod {
        return .get
    }

}
