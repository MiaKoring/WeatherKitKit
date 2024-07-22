// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZapdosKit",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ZapdosKit",
            targets: ["ZapdosKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/simon-zwicker/SwiftChameleon.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ZapdosKit", dependencies: [.byName(name: "SwiftChameleon")]),
        .testTarget(
            name: "ZapdosKitTests",
            dependencies: ["ZapdosKit"]),
    ]
)
