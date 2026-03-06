//
//  SeahorseExampleApp.swift
//  SeahorseExample
//
//  模板说明：Seahorse 风格应用入口——主窗口（默认 1200×800）+ 设置窗口。
//  可选：多窗口时可增加 WindowGroup(id: "item-detail", for: UUID.self) 等。
//

import SwiftUI

@main
struct SeahorseExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 1200, height: 800)
        .commands {
            CommandGroup(replacing: .newItem) {}
        }

        Settings {
            SettingsView()
        }
    }
}
