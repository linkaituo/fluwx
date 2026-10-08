// swift-tools-version: 5.9
import PackageDescription


let package = Package(
    name: "fluwx",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "fluwx", targets: ["fluwx"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        // 本地 vendored 副本（原远程依赖 https://github.com/JarvanMo/WechatOpenSDK-SPM 2.0.8）。
        // 改为本地包以修正 framework Info.plist 的 MinimumOSVersion（12.0 -> 15.0），
        // 修复 Xcode 26/27 archive 后 App Store 校验 ITMS-90208。
        // 详见 WechatOpenSDK-SPM/Package.swift 注释。
        .package(name: "WechatOpenSDK-SPM", path: "WechatOpenSDK-SPM")
    ],
    targets: [
        .target(
            name: "fluwx",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "WechatOpenSDK", package: "WechatOpenSDK-SPM")
            ],
            resources: [
                .process("Resources/PrivacyInfo.xcprivacy")
            ],
            cSettings: [
                .define("FLUWX_WITH_PAY"),
                .headerSearchPath("include")
            ],
            swiftSettings: [
                .define("FLUWX_WITH_PAY")
            ],
            linkerSettings: [
                .linkedFramework("CoreGraphics"),
                .linkedFramework("Security"),
                .linkedFramework("WebKit"),
                .unsafeFlags(["-ObjC", "-all_load"])
            ]
        )
    ]
)
