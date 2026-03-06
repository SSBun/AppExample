//
//  StandardListItemView.swift
//  SeahorseExample
//
//  模板说明：Seahorse 列表行——左侧图标（渐变圆角）+ 标题/副标题 + 类型标签 + 收藏 + 日期。
//  仅 Mock；hover 时背景高亮。
//

import SwiftUI
import AppKit

struct StandardListItemView: View {
    let item: MockItem
    @State private var isHovered = false

    private var itemTypeIcon: String {
        switch item.itemType {
        case .link: return "link"
        case .image: return "photo"
        case .note: return "doc.text"
        }
    }
    private var itemTypeLabel: String {
        switch item.itemType {
        case .link: return "Link"
        case .image: return "Image"
        case .note: return "Note"
        }
    }
    private var gradientColors: [Color] {
        switch item.itemType {
        case .link: return [.blue.opacity(0.6), .purple.opacity(0.6)]
        case .image: return [.green.opacity(0.6), .teal.opacity(0.6)]
        case .note: return [.orange.opacity(0.6), .pink.opacity(0.6)]
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 40, height: 40)
                Image(systemName: itemTypeIcon)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 13, weight: .medium))
                if let subtitle = item.subtitle {
                    Text(subtitle)
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            Spacer()
            Text(itemTypeLabel)
                .font(.system(size: 10))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(4)
            Button(action: {}) {
                Image(systemName: item.isFavorite ? "star.fill" : "star")
                    .font(.system(size: 12))
                    .foregroundStyle(item.isFavorite ? .yellow : .secondary)
            }
            .buttonStyle(.plain)
            .opacity(isHovered || item.isFavorite ? 1.0 : 0.5)
            Text(item.addedDate, style: .date)
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
                .frame(width: 80, alignment: .trailing)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(isHovered ? Color(NSColor.controlBackgroundColor) : Color.clear)
        )
        .onHover { isHovered = $0 }
        .contextMenu {
            Button(role: .destructive) { } label: { Label("Delete", systemImage: "trash") }
        }
    }
}

#Preview {
    StandardListItemView(item: MockData.items[0])
        .padding()
}
