// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RadioTime",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "RadioTime",
            targets: ["RadioTime"]
        )
    ],
    dependencies: [
        .package(name: "SwiftyBeaver", url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.9.5"),
    ],
    targets: [
        .target(
            name: "RadioTime",
            dependencies: [
                "SwiftyBeaver",
            ],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
