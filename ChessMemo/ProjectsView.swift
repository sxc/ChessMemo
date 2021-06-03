//
//  ProjectsView.swift
//  ChessMemo
//
//  Created by Xiaochun Shen on 2021/5/29.
//

import SwiftUI

struct ProjectsView: View {
    static let openTag: String? = "Open"
    static let closedTag: String? = "Close"
    
    @State private var showingSortOrder = false
    
    @State private var sortOrder = Item.SortOrder.optimized
    
    @State private var sortingKeyPath: PartialKeyPath<Item>?
    
    @State private var sortDescriptor: NSSortDescriptor?
    
    
    
    let sortingKeyPaths = [
        \Item.itemTitle,
        \Item.itemCreationDate
    ]
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    let showClosedProjects: Bool
    
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        
        
        
        projects = FetchRequest<Project>(entity: Project.entity(),
                                        sortDescriptors: [
                                            NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
                                        ], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(items(for: project)) { item in
                            ItemRowView(item: item)
                                
                            }
                        .onDelete { offsets in
                            let allItems = project.projectItems
                            
                            for offset in offsets {
                                let item = allItems[offset]
                                dataController.delete(item)
                            }
                            dataController.save()
                            
                        }
                        
                        if showClosedProjects == false {
                            Button {
                                withAnimation {
                                    let item = Item(context: managedObjectContext)
                                    item.project = project
                                    item.creationDate = Date()
                                    dataController.save()
                                }
                            } label: {
                                Label("Add new Item", systemImage: "plus")
                                
                            }
                        }
                        
                        }
                    }
                }
            
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
            
                if showClosedProjects == false {
                    Button {
                        withAnimation {
                            let project = Project(context: managedObjectContext)
                            project.closed = false
                            project.creationDate = Date()
                            dataController.save()
                        }
                    } label: {
                        Label("Add Project", systemImage: "plus")
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showingSortOrder.toggle()
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
            
        }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Optimized")) { sortingKeyPath = nil    },
                    .default(Text("Creation Date")) { sortingKeyPath = \Item.creationDate },
                    .default(Text("Title")) { sortingKeyPath = \Item.title }
                ])
            }
        }
    }
    
    func items(for project: Project) -> [Item] {
//        switch sortOrder {
//        case .title:
//            return project.projectItems.sorted(by: \Item.itemTitle)
//        case .creationDate:
//            return project.projectItems.sorted(by: \Item.itemCreationDate)
//        default:
//            return project.projectItemsDefaultSorted
//        }
        
//        guard let sortingKeyPath = sortingKeyPath else {
//            return project.projectItemsDefaultSorted
//        }
//
//        return project.projectItems.sorted(by: _sortingKeyPath)
        
//        if let sortingKeyPath = sortingKeyPath {
//            if sortingKeyPath == \Item.itemTitle {
//                return project.projectItems.sorted(by: sortingKeyPath, as: String.self)
//
//            } else if sortingKeyPath == \Item.itemCreationDate {
//                return  project.projectItems.sorted(by: sortingKeyPath, as: Date.self)
//            }
//        }
//
//        return project.projectItemsDefaultSorted
        
//        guard let sortDescriptor = sortDescriptor else {
//            return project.projectItemsDefaultSorted
//        }
//        return project.projectItems.sorted(by: sortDescriptor)
        
        guard let sortingKeyPath = sortingKeyPath else {
            return project.projectItemsDefaultSorted
        }
        
        return project.projectItems.sorted(by: sortingKeyPath)
        
    }
    
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
