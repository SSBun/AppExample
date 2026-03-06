//
//  SidebarView.swift
//  SeahorseExample
//
//  模板说明：Seahorse 侧栏——List 内两个 Section（CATEGORIES / TAGS），每行图标 + 文案。
//  选中项驱动主内容区过滤；仅 Mock 绑定，无拖拽等业务。
//

import SwiftUI

struct SidebarView: View {
    let categories: [MockCategory]
    let tags: [MockTag]
    @Binding var selectedCategory: MockCategory?
    @Binding var selectedTag: MockTag?
    @State private var selectedItem: MockSidebarItem?

    var body: some View {
        List(selection: $selectedItem) {
            Section {
                ForEach(categories) { category in
                    HStack(spacing: 6) {
                        Image(systemName: category.icon)
                            .foregroundStyle(category.color)
                            .frame(width: 16, height: 16)
                        Text(category.name)
                            .font(.system(size: 13))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .tag(MockSidebarItem.category(category))
                }
            } header: {
                Text("CATEGORIES")
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
            }

            Section {
                ForEach(tags) { tag in
                    HStack(spacing: 6) {
                        Circle()
                            .fill(tag.color)
                            .frame(width: 10, height: 10)
                        Text(tag.name)
                            .font(.system(size: 13))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .tag(MockSidebarItem.tag(tag))
                }
            } header: {
                Text("TAGS")
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Bookmarks")
        .frame(minWidth: 200, idealWidth: 220)
        .onChange(of: selectedItem) { _, newValue in
            switch newValue {
            case .category(let category):
                selectedCategory = category
                selectedTag = nil
            case .tag(let tag):
                selectedTag = tag
                selectedCategory = nil
            case .none:
                break
            }
        }
        .onAppear {
            if let cat = selectedCategory {
                selectedItem = .category(cat)
            } else if let tag = selectedTag {
                selectedItem = .tag(tag)
            }
        }
    }
}

#Preview {
    NavigationSplitView {
        SidebarView(
            categories: MockData.categories,
            tags: MockData.tags,
            selectedCategory: .constant(MockData.categories.first),
            selectedTag: .constant(nil)
        )
    } detail: {
        Text("Detail")
    }
    .frame(width: 400, height: 500)
}
