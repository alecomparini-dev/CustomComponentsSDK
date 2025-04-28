// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "CustomComponentsSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "UICustomComponentsSDK", targets: ["UIComponents"]),
        .library(name: "SystemCustomComponentsSDK", targets: ["SystemCustomComponents"]),
    ],
    
    dependencies: [
    ],
    
    targets: [
        
        .target(
            name: "UIComponents",
            dependencies: [
            ],
            path: "Sources/CustomComponents/UIComponents"
        ),
        
        .target(
            name: "SystemCustomComponents",
            dependencies: [
            ],
            path: "Sources/CustomComponents/SystemComponents"
        ),
    
    ]
    
)
