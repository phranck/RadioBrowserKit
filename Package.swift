// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RadioBrowserKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(name: "RadioBrowserKit", targets: ["RadioBrowserKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/sharplet/Regex.git", from: "2.1.0"),
        .package(name: "SwiftyBeaver", url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.9.0"),
    ],
    targets: [
        .target(
            name: "RadioBrowserKit",
            dependencies: ["Regex", "SwiftyBeaver"],
            path: "Sources"
        ),
        .testTarget(
            name: "RadioBrowserKitTests",
            dependencies: ["RadioBrowserKit"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
