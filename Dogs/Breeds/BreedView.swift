//
//  BreedView.swift
//  Dogs
//
//  Created by Przemek on 21/10/2022.
//

import SwiftUI

struct BreedView: View {
    @StateObject var breedViewModel = BreedViewModel()
     
     @State var breeds: [Breed] = []
     var body: some View {
         
         NavigationStack(path: $breeds) {
             List {
                 ForEach(breedViewModel.breeds, id: \.self) { breed in
                     NavigationLink {
                         BreedDetailsView(breed: breed)
                     } label: {
                        BreedViewRow(breed: breed)
                     }
                 }
             }
             .navigationTitle("Dog Breeds")
         }
         .onAppear {
             breedViewModel.getBreeds()
         }
     }
}

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        BreedView()
    }
}
