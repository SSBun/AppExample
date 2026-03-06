//
//  ContentView.swift
//  SharkExample
//
//  模板说明：根内容视图，仅负责挂载主界面（如 MainWorkspaceView）。
//  后续可在此增加全局修饰（如 .environmentObject、.sheet）而不改主界面结构。
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainWorkspaceView()
    }
}

#Preview {
    ContentView()
        .frame(width: 800, height: 500)
}
