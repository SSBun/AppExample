//
//  AISettingsPlaceholderView.swift
//  SeahorseExample
//
//  占位：AI 设置 Tab（API URL、Token 等）。真实应用见 Seahorse AISettingsView。
//

import SwiftUI

struct AISettingsPlaceholderView: View {
    @State private var apiBaseURL = "https://api.openai.com/v1"
    @State private var apiToken = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("API Base URL")
                        .font(.system(size: 13, weight: .semibold))
                    TextField("https://api.openai.com/v1", text: $apiBaseURL)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 400)
                    Text("The base URL for AI API requests.")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    Text("API Token")
                        .font(.system(size: 13, weight: .semibold))
                    SecureField("Token", text: $apiToken)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 400)
                    Text("Keep your token private.")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                Spacer(minLength: 0)
            }
            .padding(30)
        }
    }
}
