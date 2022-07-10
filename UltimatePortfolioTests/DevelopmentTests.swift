//
//  DevelopmentTests.swift
//  UltimatePortfolioTests
//
//  Created by Martijn van de Wetering on 26/06/2022.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

final class DevelopmentTests: BaseTestCase {

    func testSampleDataCreationWorks() throws {
        try dataController.createSampleData()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 5, "There should be 5 sample projects.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 50, "There should be 50 sample items.")
    }

    func testDeleteAllClearsEverything() throws {
        try dataController.createSampleData()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 0, "deleteAll() should remove all projects.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0, "deleteAll() should remove all items.")
    }

    func testExampleProjectIsClosed() {
        let project = Project.example

        XCTAssertTrue(project.closed, "Example project should be closed.")
    }

    func testExampleItemIsHighPriority() {
        let item = Item.example

        XCTAssertEqual(item.priority, 3, "Example item should have high priority.")
    }
}
