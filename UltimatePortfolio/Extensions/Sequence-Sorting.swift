//
//  Sequence-Sorting.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 27/06/2022.
//

import Foundation

extension Sequence {
    func sorted<Value>(
        by keyPath: KeyPath<Element, Value>,
        using areInIncreasingOrder: (Value, Value) throws -> Bool
    ) rethrows -> [Element] {
        try self.sorted(by: {
            try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        })
    }

    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted(by: keyPath, using: <)
    }

    func sorted(by sortDescriptor: NSSortDescriptor) throws -> [Element] {
        self.sorted {
            sortDescriptor.compare($0, to: $1) == .orderedAscending
        }
    }
}
