//
//  TagManagementPlaceholderView.swift
//  SeahorseExample
//
//  占位：标签管理 Tab（添加标签、颜色选择、列表）。真实应用见 Seahorse TagManagementView。
//

import SwiftUI

struct TagManagementPlaceholderView: View {
    @State private var newTagName = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Add New Tag")
                        .font(.system(size: 13, weight: .semibold))
                    HStack(spacing: 12) {
                        TextField("Tag name", text: $newTagName)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 200)
                        Button("Add") {}
                            .disabled(newTagName.isEmpty)
                    }
                    Text("Color picker would go here.")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                Divider()
                Text("Existing tags list (placeholder)")
                    .font(.system(size: 13, weight: .semibold))
                Spacer(minLength: 0)
            }
            .padding(30)
        }
    }
}
