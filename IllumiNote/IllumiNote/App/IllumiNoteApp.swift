//
//  IllumiNoteApp.swift
//  IllumiNote
//
//  Created by Iva Chho on 7/12/24.
//

//import SwiftUI
//
//@main
//struct IllumiNoteApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}


import SwiftUI

@main
struct IllumiNoteApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                StartScreen()
            }
        }
    }
}
