//
//  ItemRowView.swift
//  ChessMemo
//
//  Created by Xiaochun Shen on 2021/6/1.
//

import SwiftUI

struct ItemRowView: View {
    @ObservedObject var project: Project
    @ObservedObject var item: Item
   
    var icon: some View {
        if item.completed {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(Color(project.projectColor))
        } else if item.priority == 3 {
            return Image(systemName: "exclamationmark.triangle")
                .foregroundColor(Color(project.projectColor))
        } else {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(.clear)
        }
    }
    
    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
//            Text(item.itemTitle)
            Label {
                Text(item.itemTitle)
            } icon: {
                icon
            }
        
            }
        }
    }


struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(project: Project.example,item: Item.example)
    }
}
