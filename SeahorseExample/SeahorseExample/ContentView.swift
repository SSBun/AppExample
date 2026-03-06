//
//  ContentView.swift
//  SeahorseExample
//
//  模板说明：Seahorse 主界面 = NavigationSplitView（侧栏 + 详情）。
//  侧栏：分类 + 标签（Section 分组）；详情：工具栏（搜索、排序菜单、视图切换、添加菜单）+ 内容区（网格/列表）。
//  仅 Mock 数据，无业务逻辑。
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCategory: MockCategory?
    @State private var selectedTag: MockTag?
    @State private var viewMode: ViewMode = .grid
    @State private var searchText = ""
    @State private var items: [MockItem] = MockData.items
    @State private var categories: [MockCategory] = MockData.categories
    @State private var tags: [MockTag] = MockData.tags

    var body: some View {
        NavigationSplitView {
            SidebarView(
                categories: categories,
                tags: tags,
                selectedCategory: $selectedCategory,
                selectedTag: $selectedTag
            )
        } detail: {
            Group {
                if selectedCategory != nil || selectedTag != nil {
                    ItemCollectionView(items: items, viewMode: viewMode)
                        .overlay {
                            if items.isEmpty {
                                emptyStateView
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color(NSColor.windowBackgroundColor))
                            }
                        }
                } else {
                    Text("Select a category or tag")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle(selectedCategory?.name ?? "Bookmarks")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    // 搜索框（Seahorse 风格：圆角背景）
                    HStack(spacing: 6) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 12))
                        TextField("Search", text: $searchText)
                            .textFieldStyle(.plain)
                            .font(.system(size: 13))
                            .frame(width: 180)
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 11))
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Color(NSColor.controlBackgroundColor))
                    .cornerRadius(6)
                }
                ToolbarItemGroup(placement: .automatic) {
                    // 排序菜单（占位）
                    Menu {
                        Button("Date Added") {}
                        Button("Name") {}
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                            Image(systemName: "chevron.down")
                                .font(.system(size: 8))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .menuStyle(.borderlessButton)
                    Divider()
                    // 视图切换：网格 / 列表
                    Picker("View Mode", selection: $viewMode) {
                        Label("Grid", systemImage: "square.grid.2x2").tag(ViewMode.grid)
                        Label("List", systemImage: "list.bullet").tag(ViewMode.list)
                    }
                    .pickerStyle(.segmented)
                    .fixedSize()
                    Divider()
                    // 添加菜单
                    Menu {
                        Button { } label: { Label("Bookmark", systemImage: "link") }
                        Button { } label: { Label("Image", systemImage: "photo") }
                        Button { } label: { Label("Text Note", systemImage: "doc.text") }
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                    .help("Add Item")
                }
            }
        }
        .onAppear {
            if selectedCategory == nil, selectedTag == nil, let first = categories.first {
                selectedCategory = first
            }
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "bookmark.slash")
                .font(.system(size: 64))
                .foregroundStyle(.secondary)
            Text("No Bookmarks")
                .font(.title2)
                .fontWeight(.semibold)
            Text(searchText.isEmpty ? "Add your first bookmark to get started" : "No bookmarks match your search")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ContentView()
        .frame(width: 1200, height: 800)
}
