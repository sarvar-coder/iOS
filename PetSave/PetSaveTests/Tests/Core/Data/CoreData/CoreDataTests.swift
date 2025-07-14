//
//  PetSaveTests.swift
//  PetSaveTests
//
//  Created by Sarvar Boltaboyev on 11/07/25.
//

import XCTest
@testable import PetSave

class CoreDataTests: XCTestCase {

    override func setUpWithError() throws {
      try super.setUpWithError()
    }

    override func tearDownWithError() throws {
      try super.tearDownWithError()
    }
    
    func testToManagedObject() throws {
    //1
    let previewContext = PersistenceController.preview.container.viewContext
    //2
    let fetchRequest = AnimalEntity.fetchRequest()
    fetchRequest.fetchLimit = 1
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \AnimalEntity.name, ascending: true)]
    guard let results = try? previewContext.fetch(fetchRequest),
    let first = results.first else { return }
    //3
    XCTAssert(first.name == "CHARLA",
    """
    Pet name did not match, was expecting Kiki, got
    \(String(describing: first.name))
    """)
    XCTAssert(first.type == "Dog",
    """
    Pet type did not match, was expecting Cat, got
    \(String(describing: first.type))
    """)
    XCTAssert(first.coat.rawValue == "Short",
    """
    Pet coat did not match, was expecting Short, got
    \(first.coat.rawValue)
    """)
    }

    func testDeleteManagedObject() throws {
        let previewContext = PersistenceController.preview.container.viewContext
        let fetchRequest = AnimalEntity.fetchRequest()
        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first else { return }
        let expectedResult = results.count - 1
        previewContext.delete(first)
        guard let resultsAfterDeletion = try?
                previewContext.fetch(fetchRequest)
        else { return }
        XCTAssertEqual(expectedResult, resultsAfterDeletion.count, """
    The number of results was expected to be \(expectedResult)
    after deletion, was \(results.count)
    """)
    }
    
    func testFetchAnimals() {
        let previewContext = PersistenceController.preview.container.viewContext
        
        let fetchRequest = AnimalEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        guard let results = try? previewContext.fetch(fetchRequest),
              let ellie = results.first(where: { animal in
                  animal.name == "Ellie"
              }) else { return }
        
        let expectedName = "Ellie"
        
        XCTAssertEqual(expectedName, ellie.name)
        
    }
}
