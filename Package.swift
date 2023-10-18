// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "CustomComponentsSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "CustomComponentsSDK", targets: ["CustomComponentsSDK"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.30.3")
    ],

    targets: [
        
        .target(
            name: "CustomComponentsSDK",
            dependencies: [
                "SkeletonView"
            ],
            path: "Sources/CustomComponents"
        ),
        
    ]
    
)
