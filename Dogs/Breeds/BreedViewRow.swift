//
//  BreedViewRow.swift
//  Dogs
//
//  Created by Przemek on 21/10/2022.
//

import SwiftUI

struct BreedViewRow: View {
    let breed: Breed
    var body: some View {
        VStack(alignment: .leading) {
            Text(breed.name).fontWeight(.bold).font(.title2)
            Text(breed.subTitle)
        }
    }
}

struct BreedViewRow_Previews: PreviewProvider {
    static var previews: some View {
        BreedViewRow(breed: Breed(name:
                                "", subTitle: ""))
    }
}
