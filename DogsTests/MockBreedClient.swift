//
//  MockBreedHttpClient.swift
//  DogsTests
//
//  Created by Przemek on 21/10/2022.
//

import Foundation
@testable import Dogs

struct MockBreedHttpClient: HTTPClient {
    var breedResponse: BreedResponse?
    var error: RequestError?
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        guard let breedResponse = breedResponse as? T else {
            return  .failure(error!)
        }
        
        return .success(breedResponse)
    }
    
    mutating func enqueuSuccess(breedResponse: BreedResponse) {
        self.breedResponse = breedResponse
        self.error = nil
    }
    
    mutating func enqueueFailure(error: RequestError?) {
        self.error = error
        self.breedResponse = nil
    }
}
