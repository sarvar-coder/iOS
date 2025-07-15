//
//  NavigationRouter.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 15/07/25.
//

import Foundation
import SwiftUI
protocol NavigationRouter {
    
    associatedtype Data
    
    func navigate<T: View>(
        data: Data,
        navigationState: NavigationState,
        view: (() -> T)?
    ) -> AnyView
}
