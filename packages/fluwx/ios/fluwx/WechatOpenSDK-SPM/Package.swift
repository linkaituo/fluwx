// swift-tools-version: 5.7
import PackageDescription

// 本地 vendored 副本，内容来自 https://github.com/JarvanMo/WechatOpenSDK-SPM tag 2.0.8。
// 与上游的唯一差异：两个 framework 切片 Info.plist 的 MinimumOSVersion 由 12.0 改为 15.0。
//
// 原因：Xcode 26/27 会把 SPM 静态二进制 target 的 framework 拷入
// Runner.app/Frameworks（-remove-static-executable 后注入空 stub dylib，
// 日志表现为 "Injecting stub binary into codeless framework"）。
// stub dylib 的最低系统版本按 app 部署目标（15.0）编译，而 plist 保留原值 12.0，
// 两者不一致导致 App Store 上传校验失败：ITMS-90208。
// 若 app 的 IPHONEOS_DEPLOYMENT_TARGET 调整，需同步修改两个切片 plist。
let package = Package(
    name: "WechatOpenSDK-SPM",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "WechatOpenSDK",
            targets: ["WechatOpenSDK"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "WechatOpenSDK",
            path: "WechatOpenSDK.xcframework"
        )
    ]
)
