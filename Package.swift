// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "CustomComponentsSDK",
    
    platforms: [
        .iOS(.v16),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "UICustomComponentsSDK", targets: ["UICustomComponentsSDK"]),
        .library(name: "SystemCustomComponentsSDK", targets: ["SystemCustomComponentsSDK"]),
    ],
    
    dependencies: [
    ],
    
    targets: [
        
        .target(
            name: "UICustomComponentsSDK",
            dependencies: [
            ],
            path: "Sources/CustomComponents/UIComponents"
        ),
        
        .target(
            name: "SystemCustomComponentsSDK",
            dependencies: [
            ],
            path: "Sources/CustomComponents/SystemComponents"
        ),
    
    ]
    
)
