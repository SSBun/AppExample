//
//  AdvancedSettingsPlaceholderView.swift
//  SeahorseExample
//
//  占位：高级设置 Tab（复制检测、权限等）。真实应用见 Seahorse AdvancedSettingsView。
//

import SwiftUI

struct AdvancedSettingsPlaceholderView: View {
    @State private var copyDetectionEnabled = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Copy Detection")
                        .font(.system(size: 13, weight: .semibold))
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Enable Copy Detection")
                                .font(.system(size: 13, weight: .medium))
                            Text("Save items when you copy the same content twice.")
                                .font(.system(size: 11))
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Toggle("", isOn: $copyDetectionEnabled)
                            .toggleStyle(.switch)
                    }
                }
                Spacer(minLength: 0)
            }
            .padding(30)
        }
    }
}
