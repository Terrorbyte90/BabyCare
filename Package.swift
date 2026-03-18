// swift-tools-version: 5.9
// Obs: detta paket byggs via Xcode-projektet (BabyCare.xcodeproj), inte via `swift build`.
// `swift build` på macOS väljer macOS-SDK:n och kan inte kompilera iOS-specifika ramverk
// som SwiftUI, SwiftData och UIKit. Använd xcodebuild med en iOS-simulator-destination.
//
// Rätt sätt att bygga och testa:
//   xcodebuild -scheme BabyCare \
//     -project BabyCare.xcodeproj \
//     -destination "platform=iOS Simulator,name=iPhone 16" \
//     test

import PackageDescription

let package = Package(
    name: "BabyCare",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "BabyCare",
            targets: ["BabyCare"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BabyCare",
            dependencies: [],
            swiftSettings: [
                // Säkerställ att Swift känner till iOS-plattformsvillkor
                .define("IOS_PLATFORM")
            ]
        ),
        .testTarget(
            name: "BabyCareTests",
            dependencies: ["BabyCare"],
            path: "Tests/BabyCareTests"),
    ]
)