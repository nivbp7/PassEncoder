// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PassEncoder",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "PassEncoder",
            targets: ["PassEncoder"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .upToNextMajor(from: "0.9.0")),
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "PassEncoder",
            dependencies: [
                "ZIPFoundation",
                .product(name: "Crypto", package: "swift-crypto"),
            ]),
        .testTarget(
            name: "PassEncoderTests",
            dependencies: ["PassEncoder"]),
    ]
)
