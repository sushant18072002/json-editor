# JSON Editor

A powerful cross-platform JSON editor built with Flutter, providing robust CRUD operations, validation, and comparison capabilities for JSON data manipulation.

## 🚀 Features

### Core Functionality
- **Advanced JSON Viewing**
  - Syntax highlighting with color-coded elements
  - Collapsible tree view for nested structures
  - Breadcrumb navigation
  - Search with regex support
  - Virtual scrolling for large files

### CRUD Operations
- Create new nodes via context menus or drag-and-drop
- Read node details with tooltips showing type and path
- Update values inline or through modal interfaces
- Delete nodes with confirmation safeguards
- 50-step undo/redo history

### Validation & Error Handling
- Real-time JSON syntax validation
- Schema validation support
- Detailed error messages with line numbers
- Instant feedback during editing

### Comparison Tools
- Split-view diff visualization
- Highlight added, removed, or modified nodes
- Merge capabilities for multiple files

### User Experience
- Intuitive drag-and-drop interface
- Context menus for quick actions
- Light and dark theme support
- Localization (English, Spanish, French, German)
- Offline functionality
- Cross-platform support (Web, Android, iOS, Desktop)

## 🛠️ Technical Stack

- **Framework**: Flutter
- **Language**: Dart
- **Key Packages**:
  - `dart:convert` - JSON parsing/validation
  - `json_schema` - Schema validation
  - `flutter_code_editor` - Syntax highlighting
  - `file_picker` - File import/export
  - `provider` - State management
  - `flutter_treeview` - Collapsible tree UI

## 📦 Installation

```bash
# Clone the repository
git clone https://github.com/sushant18072002/json-editor.git

# Navigate to project directory
cd json-editor

# Get dependencies
flutter pub get

# Run the application
flutter run
```

## 💻 Usage

### Import JSON
- Upload JSON file
- Paste JSON text
- Fetch from API

### Export Options
- Download as `.json`
- Download as `.txt`
- Copy to clipboard
- All operations work offline

### Navigation
1. Use breadcrumbs to track current path
2. Expand/collapse nodes in tree view
3. Search using regex
4. Filter by key, value, or data type
5. Bookmark frequently accessed nodes

## 🔍 Performance

- Optimized for large JSON files
- Lazy loading implementation
- Virtual scrolling for smooth navigation
- Efficient memory usage

## 🎯 Upcoming Features

- Collaboration with multi-user editing
- Plugin system for custom extensions
- Additional export formats (CSV, XML, YAML)
- BSON and MessagePack support
- Large file handling (>1GB)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, please open an issue in the GitHub repository or contact the maintainers.

---

Built with ❤️ using Flutter
