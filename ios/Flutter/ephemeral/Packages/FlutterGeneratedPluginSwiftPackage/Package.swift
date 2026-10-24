// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "connectivity_plus", path: "../.packages/connectivity_plus-7.3.2"),
        .package(name: "file_picker_darwin", path: "../.packages/file_picker_darwin-2.3.4"),
        .package(name: "flutter_image_compress_common", path: "../.packages/flutter_image_compress_common-1.1.1"),
        .package(name: "image_cropper", path: "../.packages/image_cropper-13.0.0"),
        .package(name: "image_picker_ios", path: "../.packages/image_picker_ios-0.8.13+13"),
        .package(name: "open_file_ios", path: "../.packages/open_file_ios-1.1.0"),
        .package(name: "permission_handler_apple", path: "../.packages/permission_handler_apple-9.6.4"),
        .package(name: "printing", path: "../.packages/printing-5.15.1"),
        .package(name: "share_plus", path: "../.packages/share_plus-13.3.1"),
        .package(name: "shared_preferences_foundation", path: "../.packages/shared_preferences_foundation-2.6.0"),
        .package(name: "sqflite_darwin", path: "../.packages/sqflite_darwin-2.4.4+1"),
        .package(name: "url_launcher_ios", path: "../.packages/url_launcher_ios-6.4.2"),
        .package(name: "FlutterFramework", path: "../.packages/FlutterFramework")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "connectivity-plus", package: "connectivity_plus"),
                .product(name: "file-picker-darwin", package: "file_picker_darwin"),
                .product(name: "flutter-image-compress-common", package: "flutter_image_compress_common"),
                .product(name: "image-cropper", package: "image_cropper"),
                .product(name: "image-picker-ios", package: "image_picker_ios"),
                .product(name: "open-file-ios", package: "open_file_ios"),
                .product(name: "permission-handler-apple", package: "permission_handler_apple"),
                .product(name: "printing", package: "printing"),
                .product(name: "share-plus", package: "share_plus"),
                .product(name: "shared-preferences-foundation", package: "shared_preferences_foundation"),
                .product(name: "sqflite-darwin", package: "sqflite_darwin"),
                .product(name: "url-launcher-ios", package: "url_launcher_ios"),
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
