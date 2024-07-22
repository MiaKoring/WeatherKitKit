// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherKitKit",
    platforms: [
        .macOS(.v14),
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WeatherKitKit",
            targets: ["WeatherKitKit"]),
    ],
    dependencies: [.package(url: "https://github.com/simon-zwicker/SwiftChameleon.git", branch: "main"), .package(url: "https://github.com/simon-zwicker/Mammut.git", branch: "main")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WeatherKitKit", dependencies: [.byName(name: "SwiftChameleon"), .byName(name: "Mammut")]),
        .testTarget(
            name: "WeatherKitKitTests",
            dependencies: ["WeatherKitKit"]),
    ]
)
