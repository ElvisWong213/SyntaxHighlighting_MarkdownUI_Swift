// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SyntaxHighlightingMarkdownUI",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SyntaxHighlightingMarkdownUI",
            targets: ["SyntaxHighlightingMarkdownUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ElvisWong213/SwiftTreeSitter", branch: "fix/ios-support"),
        .package(url: "https://github.com/alex-pinkus/tree-sitter-swift", branch: "with-generated-files"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-java", exact: "0.20.2"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-javascript", exact: "0.20.3"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-rust", exact: "0.20.4"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-json", exact: "0.20.2"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-python", exact: "0.20.4"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-bash", exact: "0.20.4"),
    ], targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SyntaxHighlightingMarkdownUI",
            dependencies: [
                .product(name: "SwiftTreeSitterLayer", package: "SwiftTreeSitter"),
                .product(name: "TreeSitterSwift", package: "tree-sitter-swift"),
                .product(name: "TreeSitterJava", package: "tree-sitter-java"),
                .product(name: "TreeSitterJS", package: "tree-sitter-javascript"),
                .product(name: "TreeSitterRust", package: "tree-sitter-rust"),
                .product(name: "TreeSitterJSON", package: "tree-sitter-json"),
                .product(name: "TreeSitterPython", package: "tree-sitter-python"),
                .product(name: "TreeSitterBash", package: "tree-sitter-bash"),
            ]
        ),
        .testTarget(
            name: "SyntaxHighlightingMarkdownUITests",
            dependencies: [
                "SyntaxHighlightingMarkdownUI",
            ]
        ),
    ]
)
