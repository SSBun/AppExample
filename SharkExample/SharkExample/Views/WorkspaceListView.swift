//
//  WorkspaceListView.swift
//  SharkExample
//
//  模板说明：左侧边栏结构——标题栏 + 操作按钮 + 列表。
//  - 顶部：标题文案 + 导入/新增等图标按钮，背景与主内容区分。
//  - 列表：List(selection:) 支持单选，行内展示主标题 + 副标题（如路径）。
//  复制到新应用时保留此布局与样式，将 MockWorkspace 换成真实模型并接入业务。
//

import SwiftUI
import AppKit

struct WorkspaceListView: View {
    @Binding var workspaces: [MockWorkspace]
    @Binding var selectedWorkspace: MockWorkspace?

    var body: some View {
        VStack(spacing: 0) {
            // 顶部栏：标题 + 右侧操作按钮（与 Shark 一致：Import + Add）
            HStack {
                Text("Workspaces")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.system(size: 14, weight: .medium))
                }
                .buttonStyle(.plain)
                .help("Import existing workspace file")
                Button(action: { appendMockWorkspace() }) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .medium))
                }
                .buttonStyle(.plain)
                .help("Create new workspace")
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 36)
            .background(Color(NSColor.controlBackgroundColor))

            Divider()

            // 可选中列表，使用 sidebar 样式
            List(selection: $selectedWorkspace) {
                ForEach(workspaces) { workspace in
                    WorkspaceRowView(workspace: workspace)
                        .tag(workspace)
                }
            }
            .listStyle(.sidebar)
        }
    }

    private func appendMockWorkspace() {
        workspaces.append(MockWorkspace(
            name: "New Workspace",
            filePath: "~/Workspaces/new.code-workspace"
        ))
    }
}

// MARK: - 单行视图
/// 每行：主标题（名称）+ 副标题（路径）+ 右侧操作图标；hover 时显示操作。
struct WorkspaceRowView: View {
    let workspace: MockWorkspace
    @State private var isHovered = false

    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text(workspace.name)
                    .font(.system(size: 14, weight: .medium))
                Text(workspace.filePath)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "arrow.right.circle")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
            .opacity(isHovered ? 1.0 : 0.6)
            .help("Open in editor")
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 4)
        .contentShape(Rectangle())
        .onHover { isHovered = $0 }
        .contextMenu {
            Button(role: .destructive, action: {}) {
                Label("Remove", systemImage: "trash")
            }
            Button(action: {}) {
                Label("Show in Finder", systemImage: "folder")
            }
            Button(action: {}) {
                Label("Rename", systemImage: "pencil")
            }
        }
    }
}

#Preview {
    @Previewable @State var workspaces: [MockWorkspace] = MockData.workspaces
    @Previewable @State var selected: MockWorkspace?

    WorkspaceListView(workspaces: $workspaces, selectedWorkspace: $selected)
        .frame(width: 320, height: 400)
}
