//
//  AnimalListView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 15/07/25.
//

import SwiftUI

struct AnimalListView<Content, Data>: View
where Content: View,
      Data: RandomAccessCollection,
      Data.Element: AnimalEntity {
    let animals: Data
    let footer: Content
    @StateObject var navigationState = NavigationState()
    
    init(animals: Data, @ViewBuilder footer: () -> Content) {
        self.animals = animals
        self.footer = footer()
    }
    
    init(animals: Data) where Content == EmptyView {
        self.init(animals: animals) {
            EmptyView()
        }
    }
    var body: some View {
        List {
            Button(navigationState.isNavigatingDisabled ? "Enable Navigation" : "DisableNavigation") {
                navigationState.isNavigatingDisabled.toggle()
            }
            ForEach(animals) { animal in
                NavigationLink(destination: AnimalDetailsView(animal: animal)){
                    AnimalRow(animal: animal)
                }
                .disabled(navigationState.isNavigatingDisabled)
            }
            footer
        }
        .listStyle(.plain)
    }
    
}

struct AnimalListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnimalListView(animals:
                            CoreDataHelper.getTestAnimalEntities() ?? []) {
                Text("This is a footer")
            }
        }
        NavigationView {
            AnimalListView(animals: []) {
                Text("This is a footer")
            }
        }
    }
}
