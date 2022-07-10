//
//  UltimatePortfolioTests.swift
//  UltimatePortfolioTests
//
//  Created by Martijn van de Wetering on 25/06/2022.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }

}
