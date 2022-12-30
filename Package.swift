// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "netmera-ios",
    platforms: [.iOS(.v10)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NetmeraIOS",
            type: .dynamic,
            targets: ["NetmeraIOS"]
        ),
        .library(
            name: "NetmeraNotificationServiceExtension",
            type: .dynamic,
            targets: ["NetmeraNotificationServiceExtensionWrapper"]
        ),
        .library(
            name: "NetmeraNotificationContentExtension",
            type: .dynamic,
            targets: ["NetmeraNotificationContentExtensionWrapper"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            url: "https://github.com/AFNetworking/AFNetworking.git",
            .upToNextMajor(from: "4.0.1")
        ),
        .package(
            name: "FMDB",
            url: "https://github.com/ccgus/fmdb",
            .upToNextMajor(from: "2.7.7")
        ),
        .package(
            url: "https://github.com/kishikawakatsumi/UICKeyChainStore.git",
            .upToNextMajor(from: "2.2.1")
        ),
        .package(
            url: "https://github.com/NetmeraSDK/MMWormhole.git",
            .branchItem("feature/spm-support")
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(name: "Netmera", url: "https://github.com/Netmera/netmera-ios/releases/download/3.14.10/Netmera.xcframework.zip", checksum: "aae0f5da7a211963fd3a8cfc71ff6a3125117764ac059e9c37ded85fec7bc886"),
        .binaryTarget(
            name: "NetmeraCore",
            url: "https://github.com/Netmera/netmera-ios/releases/download/3.14.10/NetmeraCore.xcframework.zip",
            checksum: "d28b192685f64851436665695922089ff7b4364aebccb1d5a161afefda6ed420"
        ),
        .binaryTarget(
            name: "NetmeraAdId",
            url: "https://github.com/Netmera/netmera-ios/releases/download/3.14.10/NetmeraAdId.xcframework.zip",
            checksum: "97e8309c5e73abf10f0f4368078b64eb79c5d3234f6b22e19df2f46a1bdaa6c2"
        ),
        .binaryTarget(
            name: "NetmeraNotificationServiceExtension",
            path: "Frameworks/NetmeraNotificationServiceExtension.xcframework"
        ),
        .binaryTarget(
            name: "NetmeraNotificationContentExtension",
            path: "Frameworks/NetmeraNotificationContentExtension.xcframework"
        ),
        .target(
            name: "NetmeraIOS",
            dependencies: [
                "UICKeyChainStore", "MMWormhole", "FMDB", "AFNetworking", "Netmera", "NetmeraAdId", "NetmeraCore",
            ],
            linkerSettings: [
                .linkedLibrary("sqlite3"),
                .linkedFramework("CoreLocation"),
                .linkedFramework("WebKit"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("UserNotifications"),
            ]
        ),
        .target(name: "NetmeraNotificationContentExtensionWrapper",
                dependencies: [
                    .target(name: "NetmeraCore", condition: .when(platforms: [.iOS])),
                    .target(name: "NetmeraNotificationContentExtension", condition: .when(platforms: [.iOS])),
                    .product(name: "MMWormhole", package: "MMWormhole"),
                ]),
        .target(name: "NetmeraNotificationServiceExtensionWrapper",
                dependencies: [
                    .target(name: "NetmeraCore", condition: .when(platforms: [.iOS])),
                    .target(name: "NetmeraNotificationServiceExtension", condition: .when(platforms: [.iOS])),
                ]),
    ]
)
