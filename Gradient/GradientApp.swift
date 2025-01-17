//
//  GradientApp.swift
//  Gradient
//
//  Created by  玉城 on 2024/5/1.
//

import SwiftUI
import SwiftData

@main
struct GradientApp: App {
//    @EnvironmentObject var modelData: ModelData
//    @State private var modelData = ModelData()
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            NavView()
//            GradientView()
//            Content1View()
        }
//        .environmentObject(ModelData())
//        .modelContainer(sharedModelContainer)
    }
}

