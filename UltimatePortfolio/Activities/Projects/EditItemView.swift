//
//  EditItemView.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 28/05/2022.
//

import SwiftUI

struct EditItemView: View {
    let item: Item

    @EnvironmentObject var dataController: DataController

    @State var title: String
    @State var detail: String
    @State var priority: Int
    @State var completed: Bool

    init(item: Item) {
        self.item = item

        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)

    }

    var body: some View {
        Form {
            Section(header: Text("Basic settings")) {
                TextField("Item name", text: $title.onChange(update))
                TextField("Description", text: $detail.onChange(update))
            }

            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(.segmented)
            }

            Section {
                Toggle("Mark completed", isOn: $completed.onChange(update))
            }
        }
        .navigationBarTitle(Text("Edit item"))
        .onDisappear(perform: save)
    }

    func save() {
        dataController.update(item)
    }

    func update() {
        item.project?.objectWillChange.send()

        item.title = title
        item.detail = detail
        item.priority = Int16(priority)
        item.completed = completed
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}
