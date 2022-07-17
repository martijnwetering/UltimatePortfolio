//
//  Project-CoreDataHelpers.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 18/05/2022.
//

import Foundation
import SwiftUI

extension Project {
    static let colors = ["Pink", "Purple", "Red", "Orange", "Gold", "Green", "Teal",
                         "Light Blue", "Dark Blue", "Midnight", "Dark Gray", "Gray"]

    var projectTitle: String {
        return title ?? NSLocalizedString("New project", comment: "Create a new project")
    }

    var projectDetail: String {
        return detail ?? ""
    }

    var projectColor: String {
        return color ?? "Light Blue"
    }

    var allItems: [Item] {
        items?.allObjects as? [Item] ?? []
    }

    var projectItemsDefaultSorted: [Item] {
        allItems.sorted { first, second in
            if !first.completed {
                if second.completed {
                    return true
                }
            } else if first.completed {
                if !second.completed {
                    return false
                }
            }

            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }

            return first.itemCreationDate < second.itemCreationDate
        }
    }

    func projectItems(using sortOrder: Item.SortOrder) -> [Item] {
        switch sortOrder {
        case .title:
            return allItems.sorted { $0.itemTitle < $1.itemTitle }
        case .creationDate:
            return allItems.sorted { $0.itemCreationDate < $1.itemCreationDate }
        case .optimised:
            return projectItemsDefaultSorted
        }
    }

    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }

        let completedItems = originalItems.filter(\.completed)
        return Double(completedItems.count) / Double(originalItems.count)
    }

    var label: LocalizedStringKey {
        LocalizedStringKey("\(projectTitle), \(allItems.count) items, \(completionAmount * 100, specifier: "%g") % complete.") // swiftlint:disable:this line_length
    }

    static var example: Project {
        let controller = DataController.preview
        let context = controller.container.viewContext

        let project = Project(context: context)
        project.title = "Example project"
        project.detail = "This is an example project"
        project.closed = true
        project.creationDate = Date()

        return project
    }
}
