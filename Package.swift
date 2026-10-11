// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SENetworking",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SENetworking",
            targets: ["SENetworking"]),
    ],
    targets: [
        .target(
            name: "SENetworking",
            dependencies: [],
            path: "./SENetworking/Module"),
    ]
)
