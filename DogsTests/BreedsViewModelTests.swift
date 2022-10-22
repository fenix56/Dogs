//
//  DogsTests.swift
//  DogsTests
//
//  Created by Przemek on 21/10/2022.
//

import XCTest
@testable import Dogs

final class BreedsViewModelTests: XCTestCase {
    
    @MainActor func testGetBreedsSuccess() {
        
        let expectation = XCTestExpectation(
            description: "Fetching mock breed"
        )
        
        let mockBreedClient = MockBreedHttpClient(breedResponse: BreedResponse.getMockBreeds())
        
        let breedViewModel = BreedViewModel(
            httpClient: mockBreedClient)
        breedViewModel.getBreeds()
        
        let asyncWaitDuration = 0.5 // <= could be even less than 0.5 seconds even
        DispatchQueue.main.asyncAfter(deadline: .now() + asyncWaitDuration) {
            // Verify state after fetch
            XCTAssertEqual(        breedViewModel.breeds.count
                                   , 2)
            
            XCTAssertEqual(        breedViewModel.breeds[0].name
                                   , "Bluetick")
            
            XCTAssertEqual(        breedViewModel.breeds[1].name
                                   , "Pyrenees")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: asyncWaitDuration)
    }
    
    @MainActor func testGetBreedsFailure() {
        
        let expectation = XCTestExpectation(
            description: "Fetching mock breed"
        )
        
        let mockBreedClient = MockBreedHttpClient(error: RequestError.invalidURL)
        
        let breedViewModel = BreedViewModel(
            httpClient: mockBreedClient)
        breedViewModel.getBreeds()
        
        let asyncWaitDuration = 0.5 // <= could be even less than 0.5 seconds even
        DispatchQueue.main.asyncAfter(deadline: .now() + asyncWaitDuration) {
            // Verify state after fetch
            XCTAssertEqual(        breedViewModel.breeds.count
                                   , 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: asyncWaitDuration)
    }
}
extension BreedResponse {
    static func getMockBreeds() -> BreedResponse {
        return BreedResponse(message: ["pyrenees": [], "bluetick": []])
    }
}
