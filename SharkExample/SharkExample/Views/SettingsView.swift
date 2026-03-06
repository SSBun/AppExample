//
//  SettingsView.swift
//  SharkExample
//
//  模板说明：设置页 = TabView 多 Tab + 每 Tab 内 ScrollView + 区块。
//  本文件同时作为「设置项控件大全」参考：包含 Toggle、TextField、Picker（menu/segmented/radio）、
//  Slider、Stepper、Button、Alert、DisclosureGroup、DatePicker、ColorPicker 等示例。
//  复制到新应用时可按需删减 Tab 或区块，保留需要的控件写法。
//

import SwiftUI
import AppKit

// MARK: - Tab 枚举
private enum SettingsTab: String, CaseIterable, Identifiable {
    case general = "General"
    case folders = "Folders"
    case terminal = "Terminal"
    case advanced = "Advanced"
    case controls = "Controls"  // 控件示例汇总

    var id: String { rawValue }
    var icon: String {
        switch self {
        case .general: return "gearshape"
        case .folders: return "folder.badge.plus"
        case .terminal: return "terminal"
        case .advanced: return "slider.horizontal.3"
        case .controls: return "square.grid.2x2"
        }
    }
}

struct SettingsView: View {
    @State private var selectedTab: SettingsTab = .general
    // General / Folders / Terminal 用
    @State private var settingsFolderPath: String = "~/Library/Application Support/SharkExample"
    @State private var componentsSearchPath: String = ""
    @State private var selectedLocationType: LocationType = .default
    @State private var authorizedFolders: [String] = ["/Users/example/Projects"]
    @State private var selectedTerminalApp: TerminalOption = .systemDefault

    // 控件示例 Tab 用（仅 Mock 绑定）
    @State private var toggleAutoSave = true
    @State private var toggleDarkMode = false
    @State private var textFieldUsername = "demo"
    @State private var textFieldAPIKey = ""
    @State private var pickerTheme: ThemeOption = .system
    @State private var segmentedLayout: LayoutOption = .list
    @State private var radioSync: SyncOption = .wifi
    @State private var sliderVolume: Double = 0.7
    @State private var stepperCount: Int = 5
    @State private var dateLaunch = Date()
    @State private var colorAccent = Color.accentColor
    @State private var showAlert = false
    @State private var showConfirmation = false
    @State private var disclosureExpanded = true

    enum LocationType: String, CaseIterable {
        case `default` = "Default"
        case custom = "Custom"
    }
    enum TerminalOption: String, CaseIterable, Identifiable {
        case systemDefault = "System Default"
        case terminal = "Terminal"
        case iTerm = "iTerm"
        var id: String { rawValue }
    }
    enum ThemeOption: String, CaseIterable, Identifiable {
        case light = "Light"
        case dark = "Dark"
        case system = "System"
        var id: String { rawValue }
    }
    enum LayoutOption: String, CaseIterable, Identifiable {
        case list = "List"
        case grid = "Grid"
        case compact = "Compact"
        var id: String { rawValue }
    }
    enum SyncOption: String, CaseIterable, Identifiable {
        case off = "Off"
        case wifi = "Wi‑Fi only"
        case always = "Always"
        var id: String { rawValue }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            generalTabContent
                .tabItem { Label("General", systemImage: SettingsTab.general.icon) }
                .tag(SettingsTab.general)
            foldersTabContent
                .tabItem { Label("Folders", systemImage: SettingsTab.folders.icon) }
                .tag(SettingsTab.folders)
            terminalTabContent
                .tabItem { Label("Terminal", systemImage: SettingsTab.terminal.icon) }
                .tag(SettingsTab.terminal)
            advancedTabContent
                .tabItem { Label("Advanced", systemImage: SettingsTab.advanced.icon) }
                .tag(SettingsTab.advanced)
            controlsTabContent
                .tabItem { Label("Controls", systemImage: SettingsTab.controls.icon) }
                .tag(SettingsTab.controls)
        }
        .frame(width: 620, height: 560)
    }

    // MARK: - Section 通用样式（标题 + 说明 + 内容）
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 13, weight: .semibold))
    }
    private func sectionDescription(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 11))
            .foregroundStyle(.secondary)
    }
    private func pathLikeBackground(_ content: some View) -> some View {
        content
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(6)
    }

    // MARK: - General Tab
    private var generalTabContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Settings saving folder")
                    Picker("", selection: $selectedLocationType) {
                        ForEach(LocationType.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                    .frame(maxWidth: 300)
                    HStack(spacing: 8) {
                        pathLikeBackground(
                            Text(settingsFolderPath)
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                                .textSelection(.enabled)
                                .lineLimit(1)
                        )
                        if selectedLocationType == .custom { Button("Change...") {} }
                        Button(action: {}) {
                            Image(systemName: "arrow.right.circle.fill").foregroundStyle(Color.accentColor)
                        }
                        .buttonStyle(.plain)
                        .help("Reveal in Finder")
                    }
                    sectionDescription("Choose where your workspace configurations and app settings are stored.")
                }
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Components search path")
                    HStack(spacing: 8) {
                        pathLikeBackground(
                            Text(componentsSearchPath.isEmpty ? "Not set" : componentsSearchPath)
                                .font(.system(size: 12))
                                .foregroundStyle(componentsSearchPath.isEmpty ? .secondary : .primary)
                                .textSelection(.enabled)
                                .lineLimit(1)
                        )
                        Button("Set Path...") {}
                        if !componentsSearchPath.isEmpty {
                            Button(action: {}) {
                                Image(systemName: "arrow.right.circle.fill").foregroundStyle(Color.accentColor)
                            }
                            .buttonStyle(.plain)
                            .help("Reveal in Finder")
                        }
                    }
                    sectionDescription("Specify the directory where the app should look for reusable components.")
                }
                Spacer(minLength: 0)
            }
            .padding(30)
        }
    }

    // MARK: - Folders Tab
    private var foldersTabContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Folder access permissions")
                    sectionDescription("Grant the app permission to access specific directories. Required for sandboxed apps to read project files.")
                    if !authorizedFolders.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(authorizedFolders, id: \.self) { path in
                                HStack {
                                    Text(path)
                                        .font(.system(size: 11, design: .monospaced))
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                        .truncationMode(.middle)
                                    Spacer()
                                    Button(action: { authorizedFolders.removeAll { $0 == path } }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.secondary)
                                            .font(.system(size: 14))
                                    }
                                    .buttonStyle(.plain)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .background(Color(NSColor.controlBackgroundColor))
                                .cornerRadius(6)
                            }
                        }
                    }
                    Button("Grant Access to New Folder...") {}
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                }
                Spacer(minLength: 0)
            }
            .padding(30)
        }
    }

    // MARK: - Terminal Tab
    private var terminalTabContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Default terminal application")
                    Picker("Terminal App", selection: $selectedTerminalApp) {
                        ForEach(TerminalOption.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: 300)
                    sectionDescription("Detected: Terminal, iTerm")
                    Button("Select Custom Terminal App...") {}
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                    sectionDescription("Choose the terminal application to use when opening folders in terminal.")
                }
                Spacer(minLength: 0)
            }
            .padding(30)
        }
    }

    // MARK: - Advanced Tab
    private var advancedTabContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("About")
                    sectionDescription("This is an example app template. Replace with your app description.")
                }
                Spacer(minLength: 0)
            }
            .padding(30)
        }
    }

    // MARK: - Controls Tab（各类控件示例）
    private var controlsTabContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Toggle (Switch)
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Toggle (Switch)")
                    Toggle("Auto-save", isOn: $toggleAutoSave)
                    Toggle("Use dark appearance", isOn: $toggleDarkMode)
                    sectionDescription("SwiftUI: Toggle(isOn:). macOS 上呈现为开关样式。")
                }
                Divider()

                // TextField
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("TextField")
                    TextField("Username", text: $textFieldUsername)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 280)
                    TextField("API Key (optional)", text: $textFieldAPIKey)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 280)
                    sectionDescription("单行输入。SecureField 用于密码等敏感输入。")
                }
                Divider()

                // Picker — Menu（下拉）
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Picker — Menu")
                    Picker("Theme", selection: $pickerTheme) {
                        ForEach(ThemeOption.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: 200)
                    sectionDescription("Picker(selection:) + .pickerStyle(.menu) = 下拉菜单。")
                }
                Divider()

                // Picker — Segmented（分段控件）
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Picker — Segmented Control")
                    Picker("Layout", selection: $segmentedLayout) {
                        ForEach(LayoutOption.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 320)
                    sectionDescription("Picker + .pickerStyle(.segmented) = 分段选择。")
                }
                Divider()

                // Picker — Radio（单选组）
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Picker — Radio Group")
                    Picker("Sync over", selection: $radioSync) {
                        ForEach(SyncOption.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.radioGroup)
                    .frame(maxWidth: 280)
                    sectionDescription("Picker + .pickerStyle(.radioGroup) = 单选按钮组。")
                }
                Divider()

                // Slider
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Slider")
                    HStack(spacing: 12) {
                        Slider(value: $sliderVolume, in: 0...1)
                            .frame(maxWidth: 240)
                        Text(String(format: "%.0f%%", sliderVolume * 100))
                            .font(.system(size: 12, design: .monospaced))
                            .foregroundStyle(.secondary)
                            .frame(width: 40, alignment: .trailing)
                    }
                    sectionDescription("Slider(value:in:) 连续数值选择。")
                }
                Divider()

                // Stepper
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Stepper")
                    HStack(spacing: 12) {
                        Text("Count")
                        Stepper("", value: $stepperCount, in: 0...99)
                            .labelsHidden()
                        Text("\(stepperCount)")
                            .font(.system(size: 12, design: .monospaced))
                            .frame(width: 28, alignment: .trailing)
                    }
                    sectionDescription("Stepper(value:in:) 步进增减。")
                }
                Divider()

                // DatePicker
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("DatePicker")
                    DatePicker("Launch date", selection: $dateLaunch, displayedComponents: [.date, .hourAndMinute])
                        .frame(maxWidth: 300)
                    sectionDescription("DatePicker(selection:displayedComponents:) 日期/时间。")
                }
                Divider()

                // ColorPicker
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("ColorPicker")
                    ColorPicker("Accent color", selection: $colorAccent)
                        .frame(maxWidth: 200)
                    sectionDescription("ColorPicker(selection:) 颜色选择。")
                }
                Divider()

                // Button + Alert
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("Button & Alert")
                    HStack(spacing: 12) {
                        Button("Show Alert") { showAlert = true }
                            .buttonStyle(.bordered)
                        Button("Show Confirmation") { showConfirmation = true }
                            .buttonStyle(.bordered)
                    }
                    .alert("Example Alert", isPresented: $showAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("This is an alert dialog.")
                    }
                    .confirmationDialog("Confirm Action", isPresented: $showConfirmation, titleVisibility: .visible) {
                        Button("Delete", role: .destructive) {}
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Choose an option.")
                    }
                    sectionDescription(".alert(isPresented:) 单按钮提示；.confirmationDialog 多选项确认。")
                }
                Divider()

                // DisclosureGroup
                VStack(alignment: .leading, spacing: 10) {
                    sectionTitle("DisclosureGroup")
                    DisclosureGroup("Advanced options", isExpanded: $disclosureExpanded) {
                        VStack(alignment: .leading, spacing: 8) {
                            Toggle("Debug mode", isOn: .constant(false))
                            TextField("Custom endpoint", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.top, 6)
                    }
                    .frame(maxWidth: 320)
                    sectionDescription("DisclosureGroup 可折叠区块。")
                }

                Spacer(minLength: 0)
            }
            .padding(30)
        }
    }
}

#Preview {
    SettingsView()
        .frame(width: 620, height: 560)
}
