//
//  AddressFetcher.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import SwiftUI

struct AnimalDetailsView: View {
    var name: String
    @EnvironmentObject var navigationState: NavigationState
    var body: some View {
        Text(name)
        
        Button(navigationState.isNavigatingDisabled ? "Enable Navigation" : "DisableNavigation") {
            navigationState.isNavigatingDisabled.toggle()
    }
}
}

struct AnimalsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
        AnimalDetailsView(name: "Kiki")
            .environmentObject(NavigationState())
    }
    .previewLayout(.sizeThatFits)
    .previewDisplayName("iPhone SE (2nd generation)")

    NavigationView {
//      AnimalDetailsView()
    }
    .previewDevice("iPhone 12 Pro")
    .previewDisplayName("iPhone 12 Pro")
  }
}

struct AnimalDetailsRouter: NavigationRouter {
    
    typealias Data = AnimalEntity
    
    func navigate<T>(data: AnimalEntity, navigationState: NavigationState, view: (() -> T)?) -> AnyView where T : View {
        AnyView(
            
            NavigationLink {
                AnimalDetailsView(name: data.name ?? "")
                    .environmentObject(navigationState)
            } label: {
                view?()
            }
        )
    }
}
