//
//  AnimalsNearYouViewModelTestCase.swift
//  PetSaveTests
//
//  Created by Sarvar Boltaboyev on 14/07/25.
//

import Foundation
import XCTest
import CoreData
@testable import PetSave

@MainActor
final class AnimalsNearYouViewModelTestCase: XCTestCase {
    let context = PersistenceController.preview.container.viewContext
    var viewModel: AnimalsNearYouViewModel!
    
    @MainActor
    override  func setUp() {
        super.setUp()
        
        viewModel = AnimalsNearYouViewModel(
            isLoading: true,
            animalsFetcher: AnimalsFetcherMock(),
            animalStore: AnimalStoreService(context: context)
        )
    }
    
    func testFetchAnimalsLoadingState() async {
        XCTAssertTrue(viewModel.isLoading, "The view model should beloading, but it isn't")
        await viewModel.fetchAnimals(location: nil)
        XCTAssertFalse(viewModel.isLoading, "The view model should'nt be loading, but it is")
    }
    
    func testUpdatePageOnFetchMoreAnimals() async {
        XCTAssertEqual(viewModel.page, 1, "the view model's page propert should be 1 before fetching, but it's \(viewModel.page)")
        await viewModel.fetchMoreAnimals(location: nil)
        XCTAssertEqual(viewModel.page, 2, "the view model's page property  should be 2 after fetching, but it's \(viewModel.page)")
    }
    
    func testFetchAnimalsEmptyResponse() async {
    
    viewModel = AnimalsNearYouViewModel(
    isLoading: true,
    animalsFetcher: EmptyResponseAnimalsFetcherMock(),
    animalStore: AnimalStoreService(context: context)
    )
        await viewModel.fetchAnimals(location: nil)
        
        XCTAssertFalse(viewModel.hasMoreAnimals, "hasMoreAnimals should be false with an empty response, but it's true")
        XCTAssertFalse(viewModel.isLoading, "the view model shouldn't be loading after receiving an empty response, but it is")
    }
    
}
