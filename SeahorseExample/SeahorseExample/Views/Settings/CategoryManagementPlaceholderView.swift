//
//  CategoryManagementPlaceholderView.swift
//  SeahorseExample
//
//  占位：分类管理 Tab 的 UI 结构参考（添加分类、图标/颜色选择、列表）。真实应用见 Seahorse CategoryManagementView。
//

import SwiftUI

struct CategoryManagementPlaceholderView: View {
    @State private var newCategoryName = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Add New Category")
                        .font(.system(size: 13, weight: .semibold))
                    HStack(spacing: 12) {
                        TextField("Category name", text: $newCategoryName)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 200)
                        Button("Add") {}
                            .disabled(newCategoryName.isEmpty)
                    }
                    Text("Icon and color picker would go here.")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                Divider()
                Text("Existing categories list (placeholder)")
                    .font(.system(size: 13, weight: .semibold))
                Spacer(minLength: 0)
            }
            .padding(30)
        }
    }
}
