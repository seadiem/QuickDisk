// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuickDisk",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "QuickDisk",
            targets: ["QuickDisk"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files", exact: Version("4.2.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "QuickDisk",
            dependencies: ["Files"]),
        .executableTarget(
            name: "Runner",
            dependencies: ["QuickDisk"]),
        .testTarget(
            name: "QuickDiskTests",
            dependencies: ["QuickDisk"]),
    ]
)
