// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "TranslationKit",
    platforms: [
        .iOS(.v15) // Specify iOS 15.0 or higher
    ],
    products: [
        .library(
            name: "TranslationKit",
            targets: ["TranslationKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TranslationKit",
            dependencies: []),
        .testTarget(
            name: "TranslationKitTests",
            dependencies: ["TranslationKit"]),
    ]
)
