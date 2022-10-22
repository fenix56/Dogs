//
//  BreedViewModel.swift
//  Dogs
//
//  Created by Przemek on 21/10/2022.
//

import Foundation

@MainActor
class BreedViewModel: ObservableObject {
    
    let httpClient: HTTPClient
    
    @Published var breeds: [Breed]  = []
    
    init(httpClient: HTTPClient = NetworkClient()) {
        self.httpClient = httpClient
    }
    
    func getBreeds() {
        let endPoint = BreedEndPoint()
    
        Task {
            let result =   await httpClient.sendRequest(endpoint: endPoint, responseModel: BreedResponse.self)
            
            switch result {
            case .success(let breedResponse):
                    self.breeds =    breedResponse.message.keys.map {
                        
                        let values = breedResponse.message[$0]
                        let subTitle = values?.joined(separator: ",  ")
                        return Breed(name: $0.capitalized, subTitle: subTitle ?? "")
                       }.sorted { $0.name < $1.name 
                }
            case .failure:
                self.breeds = []
            }
        }
    }
}
