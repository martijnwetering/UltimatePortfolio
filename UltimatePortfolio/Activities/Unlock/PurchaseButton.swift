//
//  PurchaseButton.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 17/07/2022.
//

import SwiftUI

struct PurchaseButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 200, minHeight: 44)
            .background(Color("Light Blue"))
            .clipShape(Capsule())
            .foregroundColor(.white)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
