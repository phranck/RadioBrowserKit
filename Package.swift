// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RadioBrowser",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15),
        .tvOS(.v14),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "RadioBrowser",
            targets: ["RadioBrowser"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "RadioBrowser",
            dependencies: ["SwiftyBeaver"],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
