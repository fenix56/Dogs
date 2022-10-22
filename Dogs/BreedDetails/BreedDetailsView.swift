//
//  BreedDetailsView.swift
//  Dogs
//
//  Created by Przemek on 21/10/2022.
//

import SwiftUI

struct BreedDetailsView: View {
    @StateObject var breedDetailViewModel = BreedDetailsViewModel()
    @State var breed: Breed
    
    var body: some View {
        VStack {
            List {
                ForEach(breedDetailViewModel.breedDetail, id: \.self) { breedDetail in
                    AsyncImage(url: URL(string: breedDetail.imageName)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                        case .failure(let error):
                            Text("error: \(error.localizedDescription)")
                        case .empty:
                            ProgressView()
                        @unknown default:
                            fatalError()
                        }
                    }
                }
            }
            .onAppear {
                breedDetailViewModel.getBreedDetails(breed: breed)
            }
        }.navigationTitle(breed.name)
            .toolbar {
                Button("View More") {
                    breedDetailViewModel.getMoreBreedsImages(breed: breed)
                }
            }
    }
}

struct BreedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailsView(breed: Breed(name: "Mock", subTitle: ""))
    }
}
