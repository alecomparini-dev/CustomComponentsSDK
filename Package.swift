// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomComponentsSDK",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "CustomComponentsSDK", targets: ["CustomComponents"]),
    ],
    
    dependencies: [],

    targets: [
        
        .target(name: "CustomComponents", dependencies: []),
        
    ]
    
    
    
    
)
