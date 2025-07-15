//
//  SearchViewModelTestCase.swift
//  PetSaveTests
//
//  Created by Sarvar Boltaboyev on 15/07/25.
//

import Foundation
import XCTest
@testable import PetSave

final class SearchViewModelTestCase: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: SearchViewModel!
    let testContext = PersistenceController.preview.container.viewContext
    
    override func setUp() {
        super.setUp()
        viewModel = SearchViewModel(
            animalSearcher: AnimalSearcherMock(),
            animalStore: AnimalStoreService(context: testContext)
        )
    }
    
    func testShouldFilterIsFalseForEmptyFilters() {
    XCTAssertTrue(viewModel.searchText.isEmpty)
    XCTAssertEqual(viewModel.ageSelection, .none)
    XCTAssertEqual(viewModel.typeSelection, .none)
    XCTAssertFalse(viewModel.shouldFilter)
    }
    
    func testShouldFilterIsTrueForSearchText() {
        viewModel.searchText = "Kiki"
        XCTAssertTrue(!viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .none)
        XCTAssertEqual(viewModel.typeSelection, .none)
        XCTAssertTrue(viewModel.shouldFilter)
    }
    
    func testShouldFilterIsTrueForTypeSelection() {
        viewModel.typeSelection = .barnyard
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .none)
        XCTAssertEqual(viewModel.typeSelection, .barnyard)
        XCTAssertTrue(viewModel.shouldFilter)
    }
    
    func testShouldFilterIsTrueForAgeSelection() {
        viewModel.ageSelection = .senior
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .senior)
        XCTAssertEqual(viewModel.typeSelection, .none)
        XCTAssertTrue(viewModel.shouldFilter)
    }
    
    func testClearingFilters() {
        viewModel.searchText = "Kiki"
        viewModel.ageSelection = .adult
        viewModel.typeSelection = .barnyard
        
        XCTAssertTrue(viewModel.shouldFilter)
        
        viewModel.clearFilters()
        viewModel.searchText = ""
        
        XCTAssertFalse(viewModel.shouldFilter)
    }
    
    func testSelectTypeSuggestion() {
        viewModel.selectTypeSuggestion(.cat)
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .none)
        XCTAssertEqual(viewModel.typeSelection, .cat)
        XCTAssertTrue(viewModel.shouldFilter)
    }
}
