//
//  ItemListView.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 23/06/2022.
//

import CoreData
import SwiftUI

struct ItemListView: View {
    let title: LocalizedStringKey
    let items: FetchedResults<Item>.SubSequence

    var itemTitle: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.secondary)
            .padding(.top)
    }

    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            itemTitle

            ForEach(items) { item in
                NavigationLink(destination: EditItemView(item: item)) {
                    HStack(spacing: 20) {
                        Circle()
                            .stroke(Color(item.project?.projectColor ?? "Light Blue"), lineWidth: 3)
                            .frame(width: 44, height: 44)

                        VStack(alignment: .leading) {
                            Text(item.itemTitle)
                                .font(.title2)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if item.itemDetail.isEmpty == false {
                                Text(item.itemDetail)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(Color.secondarySystemGroupedBackground)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                }
            }
        }
    }
}

// struct ItemListView_Previews: PreviewProvider {
//    static var dataController = DataController.preview
//
//    static var previews: some View {
//        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
//        let items = FetchRequest(fetchRequest: fetchRequest).wrappedValue.prefix(1)
//
//        return ItemListView(title: "Example item", items: items)
//            .environment(\.managedObjectContext, dataController.container.viewContext)
//            .environmentObject(dataController)
//    }
// }
