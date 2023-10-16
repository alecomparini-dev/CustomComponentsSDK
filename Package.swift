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

    ],

    targets: [
        
        .target(
            name: "CustomComponentsSDK",
            dependencies: [],
            path: "Sources/CustomComponents"
        ),
        
    ]
    
    
    
    
)
