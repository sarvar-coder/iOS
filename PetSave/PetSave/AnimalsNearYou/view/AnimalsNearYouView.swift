//
//  AnimalsNearYouView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import SwiftUI

struct AnimalsNearYouView: View {
    
    private let requestManager = RequestManager()
    @State var animals = [Animal]()
    @State var isLoading = true
    
    var body: some View {
        NavigationView {
            List {
                ForEach(animals) { animal in
                    AnimalRow(animal: animal)
                }
            }
            .listStyle(.plain)
            
            .task {
                await fetchAnimals()
            }
            .overlay {
                if isLoading {
                    ProgressView("Finding Animals near you...")
                }
            }
            .navigationTitle("Animals near you")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func fetchAnimals() async {
        do {
            let animalsContainer: AnimalsContainer = try await requestManager.perform(AnimalsRequest.getAnimalsWith(page: 1, latitude: nil, longitude: nil))
            self.animals = animalsContainer.animals
            
            await stopLoading()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stopLoading() async {
        isLoading = false
    }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
  static var previews: some View {
        AnimalsNearYouView(animals: Animal.mock, isLoading: false)
  }
}
