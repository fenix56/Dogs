//
//  BreedViewMoreEndPoint.swift
//  Dogs
//
//  Created by Przemek on 21/10/2022.
//

import Foundation

struct BreedViewMoreEndPoint: Endpoint {
    var header: [String: String]?
    
    var body: [String: String]?
    
    var breedName: String
    
    var path: String {
        return "/api/breed/\(breedName.lowercased())/images"
    }
    var method: RequestMethod {
        return .get
    }
}
