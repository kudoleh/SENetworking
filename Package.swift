// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SENetworking",
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
