//
//  ProductView.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 17/07/2022.
//

import StoreKit
import SwiftUI

struct ProductView: View {
    @EnvironmentObject var unlockManager: UnlockManager
    let product: SKProduct

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Get unlimited projects")
                    .font(.headline)
                    .padding(.top, 10)
                Text("You can add three projects for free, or pay \(product.localizedPrice) to add unlimited projects.")
                Text("If you already but the unlock on another device, press Restore Purchase.")

                Button("Buy: \(product.localizedPrice)", action: unlock)
                    .buttonStyle(PurchaseButton())

                Button("Restore Purchases", action: unlockManager.restore)
                    .buttonStyle(PurchaseButton())
            }
        }
    }

    func unlock() {
        unlockManager.buy(product: product)
    }
}
