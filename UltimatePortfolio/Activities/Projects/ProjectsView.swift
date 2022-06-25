//
//  ProjectsView.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 18/05/2022.
//

import SwiftUI

struct ProjectsView: View {
    static let openTag: String? = "openTag"
    static let closedTag: String? = "closedTag"

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    @State var showingSortOrder: Bool = false
    @State var sortOrder = Item.SortOrder.optimised

    let showClosedProjects: Bool
    let projects: FetchRequest<Project>

    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        projects = FetchRequest(entity: Project.entity(),
                                sortDescriptors: [
                                    NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
                                ],
                                predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }

    var projectsList: some View {
        List {
            ForEach(projects.wrappedValue) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(project.projectItems(using: sortOrder)) { item in
                        ItemRowView(project: project, item: item)
                    }
                    .onDelete { offsets in
                        delete(offsets, from: project)
                    }

                    if showClosedProjects == false {
                        Button {
                            addItem(to: project)
                        } label: {
                            Label("Add New Item", systemImage: "plus")
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }

    var addProjectToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if showClosedProjects == false {
                Button(action: addProject) {
                    Label("Add project", systemImage: "plus")
                }
            }
        }
    }

    var sortOrderToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showingSortOrder.toggle()
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if projects.wrappedValue.isEmpty {
                    Text("There's nothing here right now")
                } else {
                    projectsList
                }
            }
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
            .toolbar {
                addProjectToolbarItem
                sortOrderToolbarItem
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Optimised")) { sortOrder = .optimised },
                    .default(Text("Creation date")) { sortOrder = .creationDate },
                    .default(Text("Title")) { sortOrder = .title },
                    .cancel()
                ])
            }

            SelectSomethingView()
        }
    }

    func addProject() {
        withAnimation {
            let project = Project(context: managedObjectContext)
            project.closed = false
            project.creationDate = Date()
            dataController.save()
        }
    }

    func addItem(to project: Project) {
        let item = Item(context: managedObjectContext)
        item.project = project
        item.creationDate = Date()
        dataController.save()
    }

    func delete(_ offsets: IndexSet, from project: Project) {
        let allItems = project.projectItems(using: sortOrder)

        for offset in offsets {
            dataController.delete(allItems[offset])
        }

        dataController.save()
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        ProjectsView(showClosedProjects: true)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
