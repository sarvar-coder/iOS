//
//  AnimalsNearYouView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import SwiftUI

struct AnimalsNearYouView: View {
    
    private let requestManager = RequestManager()
    @SectionedFetchRequest<String, AnimalEntity>(
        sectionIdentifier: \AnimalEntity.animalSpecies,
        sortDescriptors: [
            NSSortDescriptor(keyPath: \AnimalEntity.timestamp, ascending: true)
        ],
        animation: .easeInOut)
    private var sectionedAnimals: SectionedFetchResults<String, AnimalEntity>
    @State var isLoading = true
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sectionedAnimals) { animals in
                    Section(header: Text(animals.id)) {
                        ForEach(animals) { animal in 
                            NavigationLink(destination: AnimalDetailsView()) {
                                AnimalRow(animal: animal)
                            }
                        }
                    }
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
            let animalsContainer: AnimalsContainer = try await
            requestManager.perform(
                AnimalsRequest.getAnimalsWith(
                    page: 1,
                    latitude: nil,
                    longitude: nil)
            )
            for var animal in animalsContainer.animals {
                
                animal.toManagedObject()
                
            }
            await stopLoading()
        } catch {
            print("Error fetching animals...\(error)")
        }
    }
    @MainActor
    func stopLoading() async {
        isLoading = false
    }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsNearYouView(isLoading: false)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
