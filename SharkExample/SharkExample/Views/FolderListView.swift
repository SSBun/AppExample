//
//  FolderListView.swift
//  SharkExample
//
//  模板说明：右侧边栏结构——标题栏 + 操作按钮 + 列表或空状态。
//  - 顶部：标题 + 多操作按钮（如「选择组件」+「添加」）。
//  - 有数据：List 展示 FolderRow（图标 + 名称 + 路径 + 删除按钮）。
//  - 无数据：居中占位文案。
//  复制到新应用时可将 MockFolder 换成真实模型，onAddFolder/onUpdateFolder 接入业务。
//

import SwiftUI
import AppKit

struct FolderListView: View {
    @Binding var folders: [MockFolder]
    @State private var selectedFolderIDs: Set<UUID> = []
    var onAddFolder: (() -> Void)?
    var onUpdateFolder: ((MockFolder) -> Void)?
    var onSelectComponents: (() -> Void)?

    var body: some View {
        VStack(spacing: 0) {
            // 顶部栏：标题 + 右侧按钮
            HStack(spacing: 12) {
                Text("Folders")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Spacer()
                Button(action: { onSelectComponents?() }) {
                    Image(systemName: "square.grid.3x1.below.line.grid.1x2")
                        .font(.system(size: 14, weight: .medium))
                }
                .buttonStyle(.plain)
                .help("Select from search path")
                .disabled(onSelectComponents == nil)
                Button(action: { onAddFolder?() }) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .medium))
                }
                .buttonStyle(.plain)
                .help("Add folder")
                .disabled(onAddFolder == nil)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 36)
            .background(Color(NSColor.controlBackgroundColor))

            Divider()

            if folders.isEmpty {
                VStack {
                    Spacer()
                    Text("No folders")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    Spacer()
                }
            } else {
                List(selection: $selectedFolderIDs) {
                    ForEach(folders) { folder in
                        FolderRowView(
                            folder: folder,
                            onDelete: { removeFolder(folder) },
                            onShowInFinder: {}
                        )
                        .tag(folder.id)
                    }
                }
                .listStyle(.sidebar)
                .onChange(of: folders) { _, newFolders in
                    let validIDs = Set(newFolders.map(\.id))
                    selectedFolderIDs = selectedFolderIDs.intersection(validIDs)
                }
            }
        }
    }

    private func removeFolder(_ folder: MockFolder) {
        folders.removeAll { $0.id == folder.id }
    }
}

// MARK: - 单行视图
/// 行内：文件夹图标 + 名称 + 路径 + 右侧删除按钮；可选 contextMenu。
struct FolderRowView: View {
    let folder: MockFolder
    var onDelete: () -> Void
    var onShowInFinder: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "folder.fill")
                .foregroundColor(.blue)
                .font(.system(size: 14))
            VStack(alignment: .leading, spacing: 2) {
                Text(folder.listDisplayName)
                    .font(.system(size: 13))
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(folder.path)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            Button(action: onDelete) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 14))
            }
            .buttonStyle(.plain)
            .help("Remove from list")
        }
        .padding(.vertical, 4)
        .contextMenu {
            Button(role: .destructive, action: onDelete) {
                Label("Remove", systemImage: "trash")
            }
            Button(action: onShowInFinder) {
                Label("Show in Finder", systemImage: "folder")
            }
        }
    }
}

#Preview {
    @Previewable @State var folders: [MockFolder] = MockData.folders

    FolderListView(
        folders: $folders,
        onAddFolder: { folders.append(MockFolder(name: "New", path: "/new", displayName: nil)) },
        onUpdateFolder: { _ in },
        onSelectComponents: {}
    )
    .frame(width: 320, height: 400)
}
