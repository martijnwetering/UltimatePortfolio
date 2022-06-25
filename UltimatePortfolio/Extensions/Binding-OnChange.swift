//
//  Binding-OnChange.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 01/06/2022.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )

    }
}
