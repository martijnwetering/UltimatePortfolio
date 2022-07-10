//
//  ExtensionTests.swift
//  UltimatePortfolioTests
//
//  Created by Martijn van de Wetering on 27/06/2022.
//

import SwiftUI
import XCTest
@testable import UltimatePortfolio

final class ExtensionTests: XCTestCase {

    func testSequenceKeyPathSortingSelf() {
        let items = [1, 3, 2, 4, 5]
        let sortedItems = items.sorted(by: \.self)
        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "Sequence should be sorted in ascending order.")
    }

    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode to a non-empty array.")
    }

    func testDecodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(String.self, from: "DecodableString.json")
        XCTAssertEqual(data, "The rain in Spain falls mainly on the Spaniards.",
                       "The string must match the content of DecodableString.json.")
    }

    func testDecodingDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode([String: Int].self, from: "DecodableDictionary.json")
        XCTAssertEqual(data.count, 3, "There should be 3 items decoded from DecodableDictionary.json.")
        XCTAssertEqual(data["One"], 1, "The dictionary should contain Int to String mappings.")
    }

    func testBindingOnChange() {
        var onFunctionChange = false

        func exampleChangeFunction() {
            onFunctionChange = true
        }

        var storedValue = ""

        let binding = Binding(
            get: { storedValue },
            set: { storedValue = $0 }
        )

        let changedBinding = binding.onChange(exampleChangeFunction)

        changedBinding.wrappedValue = "Test"

        XCTAssertTrue(onFunctionChange, "The onChange() function must be run when the binding is changed.")
    }
}
