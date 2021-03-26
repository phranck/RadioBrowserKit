// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RadioBrowser",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "RadioBrowser",
            targets: ["RadioBrowser"]
        )
    ],
    dependencies: [
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "10.7.3"),
        .package(name: "SwiftyBeaver", url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.9.3"),
        .package(path: "../RapidAPI")
    ],
    targets: [
        .target(
            name: "RadioBrowser",
            dependencies: [
                "Realm", .product(name: "RealmSwift", package: "Realm"),
                "SwiftyBeaver",
                "RapidAPI"
            ],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
