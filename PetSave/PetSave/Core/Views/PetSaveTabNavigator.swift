//
//  PetSaveTabNavigator.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 15/07/25.
//

import Foundation

class PetSaveTabNavigator: ObservableObject {
    @Published var currentTab: PetSaveTabType = .nearYou
    
    func switchTab(to tab: PetSaveTabType) {
        currentTab = tab
    }
}


extension PetSaveTabNavigator: Hashable {
    
    static func == (lhs: PetSaveTabNavigator, rhs: PetSaveTabNavigator) -> Bool {
        lhs.currentTab == rhs.currentTab
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(currentTab)
    }
}
