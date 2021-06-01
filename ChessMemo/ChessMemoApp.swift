//
//  ChessMemoApp.swift
//  ChessMemo
//
//  Created by Xiaochun Shen on 2021/5/29.
//

import SwiftUI

@main
struct ChessMemoApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: save)
                
        }
    }
    
    func save(_ note: Notification) {
        dataController.save()
    }
    
}
