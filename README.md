# AppExample

A reference collection of SwiftUI patterns and implementations for building macOS applications.

## Purpose

This project demonstrates different SwiftUI patterns and architectures for macOS apps through practical examples:

- **Navigation patterns** - NavigationSplitView, sidebar-based navigation
- **View organization** - Grid vs list views, detail views, settings windows
- **UI components** - Cards, list items, toolbars, search interfaces
- **State management** - @State, @Binding, mock data patterns

## Projects

### SeahorseExample

A bookmark manager demo featuring:
- NavigationSplitView with sidebar (categories & tags)
- Grid/list view toggle with toolbar
- Search functionality
- Settings window

### SharkExample

A workspace manager demo featuring:
- Folder-based navigation
- Workspace list views
- Settings panel

## Usage

Browse the source code to understand the patterns. Each view is self-contained with mock data for easy understanding.

To run:
1. Open `SeahorseExample/SeahorseExample.xcodeproj` or `SharkExample/SharkExample.xcodeproj` in Xcode
2. Press ⌘R to build and run

## Requirements

- macOS 13.0+
- Xcode 15.0+

## License

MIT
