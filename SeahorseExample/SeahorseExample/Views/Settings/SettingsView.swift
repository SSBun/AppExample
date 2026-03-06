//
//  SettingsView.swift
//  SeahorseExample
//
//  模板说明：Seahorse 设置页——TabView 多 Tab（Basic / Category / Tag / AI / Advanced）。
//  每 Tab 内为 ScrollView + 区块（标题 13pt semibold，说明 11pt secondary，Divider 分隔）。
//

import SwiftUI

private enum SettingsTab: String, CaseIterable, Identifiable {
    case basic = "Basic"
    case category = "Category"
    case tag = "Tag"
    case ai = "AI"
    case advanced = "Advanced"
    var id: String { rawValue }
    var icon: String {
        switch self {
        case .basic: return "gearshape"
        case .category: return "folder.fill"
        case .tag: return "tag.fill"
        case .ai: return "sparkles"
        case .advanced: return "slider.horizontal.3"
        }
    }
}

struct SettingsView: View {
    @State private var selectedTab: SettingsTab = .basic

    var body: some View {
        TabView(selection: $selectedTab) {
            BasicSettingsView()
                .tabItem { Label("Basic", systemImage: SettingsTab.basic.icon) }
                .tag(SettingsTab.basic)
            CategoryManagementPlaceholderView()
                .tabItem { Label("Category", systemImage: SettingsTab.category.icon) }
                .tag(SettingsTab.category)
            TagManagementPlaceholderView()
                .tabItem { Label("Tag", systemImage: SettingsTab.tag.icon) }
                .tag(SettingsTab.tag)
            AISettingsPlaceholderView()
                .tabItem { Label("AI", systemImage: SettingsTab.ai.icon) }
                .tag(SettingsTab.ai)
            AdvancedSettingsPlaceholderView()
                .tabItem { Label("Advanced", systemImage: SettingsTab.advanced.icon) }
                .tag(SettingsTab.advanced)
        }
        .frame(width: 600, height: 500)
    }
}

#Preview {
    SettingsView()
        .frame(width: 600, height: 500)
}
