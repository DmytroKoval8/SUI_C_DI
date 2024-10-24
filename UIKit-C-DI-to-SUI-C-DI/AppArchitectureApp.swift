//
//  AppArchitectureApp.swift
//  SwiftUI+C+DI
//
//  Created by Admin on 24/10/2024.
//
// AppArchitectureApp.swift

import SwiftUI
@main
struct SwiftUI_C_DIApp: App {
    @StateObject var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.view()
                .environmentObject(coordinator.navigator)
        }
    }
}
