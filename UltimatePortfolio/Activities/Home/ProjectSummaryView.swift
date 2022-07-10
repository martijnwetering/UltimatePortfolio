//
//  ProjectSummaryView.swift
//  UltimatePortfolio
//
//  Created by Martijn van de Wetering on 23/06/2022.
//

import SwiftUI

struct ProjectSummaryView: View {
    @ObservedObject var project: Project

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(project.allItems.count) items")
                .font(.caption)
                .foregroundColor(.secondary)

            Text(project.projectTitle)
                .font(.title2)

            ProgressView(value: project.completionAmount)
                .accentColor(Color(project.projectColor))
        }
        .padding()
        .background(Color.secondarySystemGroupedBackground)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5)
        .accessibilityLabel(project.label)    }
}

struct ProjectSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSummaryView(project: Project.example)
    }
}
