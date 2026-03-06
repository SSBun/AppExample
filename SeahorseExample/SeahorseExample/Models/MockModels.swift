//
//  MockModels.swift
//  SeahorseExample
//
//  模板说明：Seahorse 风格侧栏（分类 + 标签）与内容区（卡片/列表）所需的 Mock 数据。
//  真实应用可替换为 Category、Tag、AnyCollectionItem 等。
//

import Foundation
import SwiftUI

// MARK: - Mock Category（侧栏「分类」）
struct MockCategory: Identifiable, Hashable {
    let id: UUID
    var name: String
    var icon: String
    var colorHex: String
    var color: Color { Color(hex: colorHex) ?? .blue }

    init(id: UUID = UUID(), name: String, icon: String, colorHex: String = "#007AFF") {
        self.id = id
        self.name = name
        self.icon = icon
        self.colorHex = colorHex
    }
}

// MARK: - Mock Tag（侧栏「标签」）
struct MockTag: Identifiable, Hashable {
    let id: UUID
    var name: String
    var colorHex: String
    var color: Color { Color(hex: colorHex) ?? .blue }

    init(id: UUID = UUID(), name: String, colorHex: String = "#007AFF") {
        self.id = id
        self.name = name
        self.colorHex = colorHex
    }
}

// MARK: - Mock Item（内容区卡片/列表项，统一类型便于示例）
enum MockItemType: String, CaseIterable {
    case link
    case image
    case note
}

struct MockItem: Identifiable, Hashable {
    let id: UUID
    var title: String
    var subtitle: String?
    var itemType: MockItemType
    var isFavorite: Bool
    var addedDate: Date

    init(id: UUID = UUID(), title: String, subtitle: String? = nil, itemType: MockItemType, isFavorite: Bool = false, addedDate: Date = Date()) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.itemType = itemType
        self.isFavorite = isFavorite
        self.addedDate = addedDate
    }
}

// MARK: - ViewMode（网格 / 列表）
enum ViewMode: String, CaseIterable {
    case grid = "Grid"
    case list = "List"
}

// MARK: - 侧栏选中项（分类 or 标签）
enum MockSidebarItem: Hashable {
    case category(MockCategory)
    case tag(MockTag)
}

// MARK: - Color hex 扩展（仅示例用）
extension Color {
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default: return nil
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}

// MARK: - 共享 Mock 数据
enum MockData {
    static let categories: [MockCategory] = [
        MockCategory(name: "All Bookmarks", icon: "bookmark.fill", colorHex: "#007AFF"),
        MockCategory(name: "Favorites", icon: "star.fill", colorHex: "#FFCC00"),
        MockCategory(name: "Work", icon: "briefcase.fill", colorHex: "#34C759"),
    ]
    static let tags: [MockTag] = [
        MockTag(name: "design", colorHex: "#AF52DE"),
        MockTag(name: "dev", colorHex: "#FF9500"),
    ]
    static let items: [MockItem] = [
        MockItem(title: "Apple Developer", subtitle: "https://developer.apple.com", itemType: .link, isFavorite: true),
        MockItem(title: "Sample Image", subtitle: nil, itemType: .image),
        MockItem(title: "Meeting Notes", subtitle: "Quick notes...", itemType: .note, isFavorite: false),
    ]
}
