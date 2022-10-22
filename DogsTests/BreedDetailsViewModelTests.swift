//
//  BreedDetailsViewModelTests.swift
//  DogsTests
//
//  Created by Przemek on 21/10/2022.
//

import XCTest
@testable import Dogs

final class BreedDetailsViewModelTests: XCTestCase {
    
    @MainActor func testGetBreedsDetailsSuccess() {
        
        let expectation = XCTestExpectation(
            description: "Fetching mock breed details"
        )
        
        let mockBreedDetailsClient = MockBreedDetailsClient(breedDetailResponse: BreedDetailsResopnse.getMockBreedDetails())
        
        let breedDetailsViewModel = BreedDetailsViewModel(
            httpClient: mockBreedDetailsClient)
        
        let breed = Breed(name: "test", subTitle: "")
        breedDetailsViewModel.getBreedDetails(breed: breed)
        
        let asyncWaitDuration = 0.5 // <= could be even less than 0.5 seconds even
        DispatchQueue.main.asyncAfter(deadline: .now() + asyncWaitDuration) {
            // Verify state after fetch
            XCTAssertEqual(        breedDetailsViewModel.breedDetail.count
                                   , 3)
            
            XCTAssertEqual(        breedDetailsViewModel.breedDetail[0].imageName
                                   , "testUrl1")
            
            XCTAssertEqual(        breedDetailsViewModel.breedDetail[1].imageName
                                   , "testUrl2")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: asyncWaitDuration)
    }
    
    @MainActor func testGetBreedsDetailsFailure() {
        
        let expectation = XCTestExpectation(
            description: "Fetching mock breed details"
        )
        
        let mockBreedDetailsClient = MockBreedDetailsClient(error: RequestError.decode)
        
        let breedDetailsViewModel = BreedDetailsViewModel(
            httpClient: mockBreedDetailsClient)
        
        let breed = Breed(name: "test", subTitle: "")
        breedDetailsViewModel.getBreedDetails(breed: breed)
        
        let asyncWaitDuration = 1.0 // <= could be even less than 0.5 seconds even
        DispatchQueue.main.asyncAfter(deadline: .now() + asyncWaitDuration) {
            // Verify state after fetch
            XCTAssertEqual(breedDetailsViewModel.breedDetail.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: asyncWaitDuration)
    }
}

extension BreedDetailsResopnse {
    static func getMockBreedDetails() -> BreedDetailsResopnse {
        return BreedDetailsResopnse(message: ["testUrl1", "testUrl2", "testUrl3"])
    }
}
