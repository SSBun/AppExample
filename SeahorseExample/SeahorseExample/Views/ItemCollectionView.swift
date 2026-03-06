//
//  ItemCollectionView.swift
//  SeahorseExample
//
//  模板说明：Seahorse 内容区——根据 viewMode 切换网格（LazyVGrid + 卡片）或列表（LazyVStack + 行视图）。
//  网格：adaptive 列宽；列表：单列行。仅展示 Mock 数据。
//

import SwiftUI

struct ItemCollectionView: View {
    let items: [MockItem]
    let viewMode: ViewMode

    var body: some View {
        ScrollView {
            if viewMode == .grid {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 240), spacing: 20)], spacing: 20) {
                    ForEach(items) { item in
                        StandardCardView(item: item)
                    }
                }
                .padding(20)
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(items) { item in
                        StandardListItemView(item: item)
                    }
                }
                .padding(16)
            }
        }
    }
}

#Preview("Grid") {
    ItemCollectionView(items: MockData.items, viewMode: .grid)
        .frame(width: 800, height: 600)
}

#Preview("List") {
    ItemCollectionView(items: MockData.items, viewMode: .list)
        .frame(width: 800, height: 600)
}
