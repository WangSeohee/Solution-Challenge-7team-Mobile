//
//  PpigcycleApp.swift
//  Ppigcycle
//
//  Created by Jinhee on 2023/02/25.
//

import SwiftUI

@main
struct PpigcycleApp: App {
    
    var body: some Scene {
        WindowGroup {
            SplashView()
            //ContentView()
            //LoginView()
        }
    }
    
//    @StateObject private var vm = AppViewModel()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environmentObject(vm)
//                .task {
//                    await vm.requestDataScannerAccessStatus()
//                }
//        }
//    }
}
