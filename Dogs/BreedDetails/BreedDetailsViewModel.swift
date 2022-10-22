//
//  BreedDetailsViewModel.swift
//  Dogs
//
//  Created by Przemek on 21/10/2022.
//

import Foundation

@MainActor
class BreedDetailsViewModel: ObservableObject {
    
    let httpClient: HTTPClient
    
    @Published var breedDetail: [BreedDetail]  = []
    
    init(httpClient: HTTPClient = NetworkClient()) {
        self.httpClient = httpClient
    }
    
    func getBreedDetails(breed: Breed) {
        let endPoint = BreedDetailsEndPoint(breedName: breed.name)
    
        Task {
            let result =   await httpClient.sendRequest(endpoint: endPoint, responseModel: BreedDetailsResopnse.self)
            
            switch result {
            case .success(let breedDetailsResponse):
                breedDetail =    breedDetailsResponse.message  .map {
                 BreedDetail(imageName: $0)
                }
            case .failure(let error ):
                print( error)
            }
        }
    }
    
    func getMoreBreedsImages(breed: Breed) {
        let endPoint = BreedViewMoreEndPoint(breedName: breed.name)
    
        Task {
            let result =   await httpClient.sendRequest(endpoint: endPoint, responseModel: BreedDetailsResopnse.self)
            
            switch result {
            case .success(let breedDetailsResponse):
                breedDetail =    breedDetailsResponse.message  .map {
                 BreedDetail(imageName: $0)
                }
            case .failure(let error ):
                print( error)
            }
        }
    }
}
