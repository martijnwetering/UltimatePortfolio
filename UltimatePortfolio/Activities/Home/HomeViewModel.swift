//
//  HomeViewModel.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 03/07/2022.
//

import CoreData
import Foundation

extension HomeView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        private let projectsController: NSFetchedResultsController<Project>
        private let itemsController: NSFetchedResultsController<Item>

        @Published var projects = [Project]()
        @Published var items = [Item]()
        @Published var selectedItem: Item?

        var upNext: ArraySlice<Item> {
            items.prefix(3)
        }

        var moreToExplore: ArraySlice<Item> {
            items.dropFirst(3)
        }

        var dataController: DataController

        init(dataController: DataController) {
            self.dataController = dataController

            let projectsRequest: NSFetchRequest<Project> = Project.fetchRequest()
            projectsRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Project.title, ascending: false)]
            projectsRequest.predicate = NSPredicate(format: "closed = false")

            projectsController = NSFetchedResultsController(
                fetchRequest: projectsRequest,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            let itemsRequest: NSFetchRequest<Item> = Item.fetchRequest()
            let completedPredicate = NSPredicate(format: "completed = false")
            let openPredicate = NSPredicate(format: "project.closed = false")
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [
                completedPredicate, openPredicate
            ])
            itemsRequest.predicate = compoundPredicate
            itemsRequest.sortDescriptors = [
                NSSortDescriptor(keyPath: \Item.priority, ascending: false)
            ]
            itemsRequest.fetchLimit = 10
            itemsController = NSFetchedResultsController(
                fetchRequest: itemsRequest,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            super.init()

            projectsController.delegate = self
            itemsController.delegate = self

            do {
                try projectsController.performFetch()
                try itemsController.performFetch()
                projects = projectsController.fetchedObjects ?? []
                items = itemsController.fetchedObjects ?? []

            } catch {
                print("Failed to load initial data.")
            }
        }

        func selectItem(with identifier: String) {
            selectedItem = dataController.item(with: identifier)
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newItems = controller.fetchedObjects as? [Project] {
                projects = newItems
            } else if let newProjects = controller.fetchedObjects as? [Item] {
                items = newProjects
            }
        }

        func createSampleData() {
            dataController.deleteAll()
            try? dataController.createSampleData()
        }
    }
}
