//
//  PetSaveApp.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//
import PetSaveOnboarding
import SwiftUI

@main
struct PetSaveApp: App {
    @AppStorage(AppUserDefaultsKeys.onboarding) var shouldPresentOnboarding = true
    var onboardingModels: [PetSaveOnboarding.OnboardingModel] {
        [
            PetSaveOnboarding.OnboardingModel(
                title: "Welcome to\n PetSave",
                description:
                    "Looking for a Pet?\n Then you're at the right place",
                image: .bird
            ),
            PetSaveOnboarding.OnboardingModel(
                title: "Search...",
                description:
                    "Search from a list of our huge database of animals.",
                image: .dogBoneStand
            ),
            PetSaveOnboarding.OnboardingModel(
                title: "Nearby",
                description:
                    "Find pets to adopt from nearby your place...",
                image: .chameleon
            )
        ]
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .fullScreenCover(
                    isPresented: $shouldPresentOnboarding, onDismiss: nil) {
                       PetSaveOnboardingView(items: onboardingModels)
                        .onSkip { // 3
                            shouldPresentOnboarding = false
                        }
                }
        }
    }
}
