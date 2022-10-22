//
//  MockBreedDetailsClient.swift
//  DogsTests
//
//  Created by Przemek on 21/10/2022.
//

import Foundation
@testable import Dogs

struct MockBreedDetailsClient: HTTPClient {
    var breedDetailResponse: BreedDetailsResopnse?
    var error: RequestError?
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        guard let breedDetailResponse = breedDetailResponse as? T else {
            return  .failure(error!)
        }
        return .success(breedDetailResponse)
    }
    
    mutating func enqueuSuccess(breedDetailResponse: BreedDetailsResopnse) {
        self.breedDetailResponse = breedDetailResponse
        self.error = nil
    }
    
    mutating func enqueueFailure(error: RequestError?) {
        self.error = error
        self.breedDetailResponse = nil
    }
    
}
