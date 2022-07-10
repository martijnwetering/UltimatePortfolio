//
//  Item-CoreDataHelpers.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 18/05/2022.
//

import Foundation

extension Item {
    enum SortOrder {
        case optimised, title, creationDate
    }

    var itemTitle: String {
        return title ?? NSLocalizedString("New item", comment: "Create a new item")
    }

    var itemDetail: String {
        return detail ?? ""
    }

    var itemCreationDate: Date {
        return creationDate ?? Date()
    }

    static var example: Item {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext

        let item = Item(context: viewContext)
        item.title = "Example item"
        item.detail = "This is an example item"
        item.priority = 3
        item.creationDate = Date()

        return item
    }
}
