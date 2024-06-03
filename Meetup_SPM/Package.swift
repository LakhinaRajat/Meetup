// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Meetup_SPM",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Meetup_SPM",
            targets: ["Meetup_SPM"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.1"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
        .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", from: "4.0.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "3.0.0"),
        .package(url: "https://github.com/livekit/client-sdk-swift.git", from: "1.1.6")
    ],
    targets: [
        .target(
            name: "Meetup_SPM",
            dependencies: [
                "Alamofire",
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                "SFSafeSymbols",
                "KeychainAccess",
                .product(name: "LiveKit", package: "client-sdk-swift"),
            ],
            path: "Sources/Meetup_SPM",
            exclude: ["Assets"]
        ),
        .testTarget(
            name: "Meetup_SPMTests",
            dependencies: ["Meetup_SPM"],
            path: "Tests/Meetup_SPMTests"
        ),
    ]
)
