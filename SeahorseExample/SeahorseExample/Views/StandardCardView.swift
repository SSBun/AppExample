//
//  StandardCardView.swift
//  SeahorseExample
//
//  模板说明：Seahorse 风格卡片——预览区（占位渐变/图标）+ 底部条（标题 + 收藏/分类/标签/类型）。
//  无网络图、无 DataStorage；仅 Mock 展示与 hover 缩放。
//

import SwiftUI
import AppKit

struct StandardCardView: View {
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

    var body: some View {
        ZStack(alignment: .bottom) {
            // 预览区占位
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        colors: [Color.gray.opacity(0.2), Color.gray.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    Image(systemName: itemTypeIcon)
                        .font(.system(size: 48))
                        .foregroundStyle(.secondary.opacity(0.5))
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))

            // 底部条：标题 + 元信息
            VStack(spacing: 0) {
                Text(item.title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    .padding(.top, 4)
                    .padding(.bottom, 2)
                HStack(spacing: 5) {
                    Button(action: {}) {
                        Image(systemName: item.isFavorite ? "star.fill" : "star")
                            .font(.system(size: 10))
                            .foregroundStyle(item.isFavorite ? .yellow : .secondary)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    HStack(spacing: 3) {
                        Image(systemName: itemTypeIcon)
                            .font(.system(size: 8))
                        Text(itemTypeLabel)
                            .font(.system(size: 8))
                    }
                    .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
            }
            .background { Rectangle().fill(Color.black.opacity(0.5)) }
        }
        .background { RoundedRectangle(cornerRadius: 12).fill(Color(NSColor.controlBackgroundColor)) }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .aspectRatio(4/3, contentMode: .fit)
        .scaleEffect(isHovered ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isHovered)
        .onHover { isHovered = $0 }
        .contextMenu {
            Button { } label: { Label("Favorite", systemImage: "star") }
            Button(role: .destructive) { } label: { Label("Delete", systemImage: "trash") }
        }
    }
}

#Preview {
    StandardCardView(item: MockData.items[0])
        .frame(width: 280)
        .padding()
}
