//
//  SharkExampleApp.swift
//  SharkExample
//
//  模板说明：Shark 风格的应用入口——主窗口 + 系统设置窗口。
//  复制到新应用时保留 WindowGroup 与 Settings 的结构，按需添加/移除 commands。
//

import SwiftUI

@main
struct SharkExampleApp: App {
    var body: some Scene {
        // 主窗口：承载主界面（如左右分栏的列表）
        WindowGroup {
            ContentView()
        }
        // 可选：隐藏菜单栏的「新建」以避免多窗口（按需保留）
        // .commands { CommandGroup(replacing: .newItem) { } }

        // 系统设置窗口：Cmd+, 打开，使用 TabView 多 Tab 的设置页风格
        Settings {
            SettingsView()
        }
    }
}
