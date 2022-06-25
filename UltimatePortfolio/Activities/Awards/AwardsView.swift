//
//  AwardsView.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 13/06/2022.
//

import SwiftUI

struct AwardsView: View {
    static let tag: String? = "Awards"

    @EnvironmentObject var dataController: DataController
    @State var selectedAward = Award.example
    @State var showingUnlockedAwardDetails = false
    @State var showingLockedAwardDetails = false

    let columns: [GridItem] = [GridItem(.adaptive(minimum: 100, maximum: 100))]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            if dataController.hasEarned(award: award) {
                                showingUnlockedAwardDetails = true
                            } else {
                                showingLockedAwardDetails = true
                            }
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(dataController.hasEarned(award: award)
                                                    ? Color(award.color)
                                                    : .secondary.opacity(0.5))
                        }
                    }
                }
            }
            .navigationTitle("Awards")
        }
        .alert(Text("Unlocked: \(selectedAward.name)"), isPresented: $showingUnlockedAwardDetails,
               actions: {}, message: { Text(selectedAward.description)
               })
        .alert(Text("Locked"), isPresented: $showingLockedAwardDetails, actions: {}, message: {
            Text(selectedAward.description)
        })
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
    }
}
