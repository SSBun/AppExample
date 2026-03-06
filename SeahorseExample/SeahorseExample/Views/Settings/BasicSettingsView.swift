//
//  BasicSettingsView.swift
//  SeahorseExample
//
//  模板说明：Seahorse 风格「基础设置」——ScrollView + 多区块（标题 13pt semibold、说明 11pt secondary、
//  路径框 controlBackgroundColor + cornerRadius(6)、Picker/Toggle/Button）。
//  仅 Mock 绑定，无持久化。
//

import SwiftUI
import AppKit

struct BasicSettingsView: View {
    @State private var appLanguage = "System"
    @State private var accentColorIndex = 0
    @State private var launchAtLogin = false
    @State private var appearanceMode = "System"
    @State private var storagePath = "~/Library/Application Support/SeahorseExample"
    @State private var showRestartAlert = false

    private let colorOptions: [Color] = [.blue, .purple, .green, .orange]
    private let appearanceOptions = ["Light", "Dark", "System"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // 语言
                VStack(alignment: .leading, spacing: 10) {
                    Text("App Language")
                        .font(.system(size: 13, weight: .semibold))
                    Picker("", selection: $appLanguage) {
                        Text("System").tag("System")
                        Text("English").tag("English")
                        Text("简体中文").tag("简体中文")
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                    .frame(maxWidth: 300)
                    Text("Restart may be required to apply.")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                Divider()

                // 主题色
                VStack(alignment: .leading, spacing: 10) {
                    Text("Primary Color")
                        .font(.system(size: 13, weight: .semibold))
                    HStack(spacing: 12) {
                        ForEach(Array(colorOptions.enumerated()), id: \.offset) { index, color in
                            Circle()
                                .fill(color)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Circle()
                                        .stroke(Color.primary, lineWidth: accentColorIndex == index ? 3 : 0)
                                )
                                .onTapGesture { accentColorIndex = index }
                        }
                    }
                }
                Divider()

                // 启动时登录
                VStack(alignment: .leading, spacing: 10) {
                    Text("Startup")
                        .font(.system(size: 13, weight: .semibold))
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Launch at login")
                                .font(.system(size: 13, weight: .medium))
                            Text("Open app when you log in.")
                                .font(.system(size: 11))
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Toggle("", isOn: $launchAtLogin)
                            .toggleStyle(.switch)
                    }
                }
                Divider()

                // 外观
                VStack(alignment: .leading, spacing: 10) {
                    Text("Appearance")
                        .font(.system(size: 13, weight: .semibold))
                    Picker("", selection: $appearanceMode) {
                        ForEach(appearanceOptions, id: \.self) { Text($0).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .frame(maxWidth: 300)
                }
                Divider()

                // 存储路径
                VStack(alignment: .leading, spacing: 10) {
                    Text("Preference Folder")
                        .font(.system(size: 13, weight: .semibold))
                    HStack(spacing: 8) {
                        Text(storagePath)
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(NSColor.controlBackgroundColor))
                            .cornerRadius(6)
                        Button("Change...") {}
                        Button("Reset") {}
                    }
                    Text("Where bookmarks and app data are stored.")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                Divider()

                // 导出/导入
                VStack(alignment: .leading, spacing: 10) {
                    Text("Data Management")
                        .font(.system(size: 13, weight: .semibold))
                    HStack(spacing: 12) {
                        Button { } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "square.and.arrow.up")
                                Text("Export")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        Button { } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "square.and.arrow.down")
                                Text("Import")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                    .frame(maxWidth: 300)
                    Text("Export or import your data as backup.")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                Spacer(minLength: 0)
            }
            .padding(30)
        }
        .alert("Restart Required", isPresented: $showRestartAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please restart the app to apply language changes.")
        }
    }
}

#Preview {
    BasicSettingsView()
        .frame(width: 600, height: 500)
}
