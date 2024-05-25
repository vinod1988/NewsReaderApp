//
//  NewsReaderAppApp.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 23/05/24.
//

import SwiftUI

@main
struct NewsReaderAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
