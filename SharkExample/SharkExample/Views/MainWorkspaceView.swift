//
//  MainWorkspaceView.swift
//  SharkExample
//
//  模板说明：主界面为左右分栏 (HSplitView)。
//  - 左侧：列表（如工作区/项目列表），固定宽度范围。
//  - 右侧：详情或第二列表（如文件夹/子项），可再分栏或放详情。
//  所有数据均为 Mock，无持久化与业务逻辑。
//

import SwiftUI

struct MainWorkspaceView: View {
    // MARK: - Mock 数据（实际应用中替换为 ViewModel / Manager 驱动）
    @State private var workspaces: [MockWorkspace] = MockData.workspaces
    @State private var selectedWorkspace: MockWorkspace?
    @State private var folders: [MockFolder] = MockData.folders
    /// 可选：用于弹出「选择组件」等 sheet（本 Example 仅占位）
    @State private var showComponentSelector = false

    var body: some View {
        HSplitView {
            // 左侧：主列表（工作区/项目等）
            WorkspaceListView(
                workspaces: $workspaces,
                selectedWorkspace: $selectedWorkspace
            )
            .frame(minWidth: 250, idealWidth: 300, maxWidth: 400)

            // 右侧：次级列表或详情（文件夹/子项等）
            FolderListView(
                folders: $folders,
                onAddFolder: { addFolderPlaceholder() },
                onUpdateFolder: { _ in },
                onSelectComponents: { showComponentSelector = true }
            )
            .frame(minWidth: 250, idealWidth: 300)
        }
        .frame(minWidth: 500, minHeight: 400)
        // 可选：选中左侧项时同步右侧数据（Example 中仅做占位）
        .onChange(of: selectedWorkspace) { _, _ in
            // 真实应用：根据 selectedWorkspace 加载对应 folders
        }
        .sheet(isPresented: $showComponentSelector) {
            // 占位：真实应用可替换为 ComponentSelectorView 等
            Text("Component Selector (placeholder)")
                .frame(width: 400, height: 300)
        }
    }

    private func addFolderPlaceholder() {
        folders.append(MockFolder(
            name: "New Folder",
            path: "/path/to/new/folder",
            displayName: nil
        ))
    }
}

// 使用 Models/MockModels 中的 MockData

#Preview {
    MainWorkspaceView()
        .frame(width: 800, height: 500)
}
