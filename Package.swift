// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "QKSliderView",
    products: [
        .library(name: "QKSliderView", targets: ["QKSliderView"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "QKSliderView",
            path: "QKSliderView")
    ]
)
