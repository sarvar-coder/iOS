//
//  AnimalRow.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 12/07/25.
//

import SwiftUI

struct AnimalRow: View {
    let animal: AnimalEntity
    
    var animalType: String {
        animal.type ?? ""
    }
    var animalBreedAndType: String {
    "\(animal.breed) \(animalType)"
    }
    
    
    var body: some View {
        HStack {
            AsyncImage(url: animal.picture) { image in
                image
                    .resizable()
            } placeholder: {
                Image("rw-logo")
                    .resizable()
                    .overlay {
                        if animal.picture != nil {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.gray.opacity(0.4))
                        }
                    }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 112, height: 112)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(animal.name ?? "No Name Available")
                    .multilineTextAlignment(.center)
                    .font(.custom(.customFont, size: 18, relativeTo: .title3))
                Text(animalBreedAndType)
                    .font(.custom(.customFont, size: 15, relativeTo: .callout))
                if let description = animal.desc {
                    Text(description)
                        .lineLimit(2)
                        .font(.footnote)
                }
                
                HStack {
                    Text(animal.age.rawValue)
                        .modifier(AnimalAttributesCard(color: animal.age.color))
                        
                    Text(animal.gender.rawValue)
                        .modifier(AnimalAttributesCard(color: .pink))
                }
            }
            .lineLimit(1)
        }
    }
}

struct AnimalRow_Previews: PreviewProvider {
    static var previews: some View {
        if let animal = CoreDataHelper.getTestAnimalEntity() {
            AnimalRow(animal: animal)
        }
    }
}

