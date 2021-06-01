//
//  ProjectHeaderView.swift
//  ChessMemo
//
//  Created by Xiaochun Shen on 2021/6/1.
//

import SwiftUI

struct ProjectHeaderView: View {
    @ObservedObject var project: Project
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.projectTitle)
                
                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
            }
            
            Spacer()
            
            NavigationLink(
                destination: EmptyView()) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                }
        }
//        .frame(minHeight: 50)
        .padding(.bottom, 10)
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
