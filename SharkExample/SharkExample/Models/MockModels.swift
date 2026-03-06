//
//  MockModels.swift
//  SharkExample
//
//  模板说明：仅用于 Example 的 Mock 数据结构，无业务逻辑。
//  后续新应用可替换为真实 Model（如 Workspace、Folder）。
//

import Foundation

// MARK: - Mock Workspace
/// 左侧列表项的数据模型示例。真实应用中可对应「工作区 / 项目 / 会话」等。
struct MockWorkspace: Identifiable, Hashable {
    let id: UUID
    var name: String
    /// 例如工作区文件的路径，或任意主键/路径
    var filePath: String

    init(id: UUID = UUID(), name: String, filePath: String) {
        self.id = id
        self.name = name
        self.filePath = filePath
    }
}

// MARK: - Mock Folder
/// 右侧列表项的数据模型示例。真实应用中可对应「文件夹 / 项目根目录 / 资源」等。
struct MockFolder: Identifiable, Hashable {
    let id: UUID
    var name: String
    var path: String
    /// 可选显示名，用于列表展示（若为 nil 则用 name）
    var displayName: String?

    init(id: UUID = UUID(), name: String, path: String, displayName: String? = nil) {
        self.id = id
        self.name = name
        self.path = path
        self.displayName = displayName
    }

    /// 列表展示用名称
    var listDisplayName: String { displayName ?? name }
}

// MARK: - 共享 Mock 数据（用于界面与 Preview）
enum MockData {
    static let workspaces: [MockWorkspace] = [
        MockWorkspace(name: "My Project", filePath: "~/Workspaces/my-project.code-workspace"),
        MockWorkspace(name: "Demo App", filePath: "~/Workspaces/demo.code-workspace"),
    ]
    static let folders: [MockFolder] = [
        MockFolder(name: "Shark", path: "/Users/example/Shark", displayName: "Shark"),
        MockFolder(name: "Seahorse", path: "/Users/example/Seahorse", displayName: nil),
    ]
}
