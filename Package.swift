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
            dependencies: []),
        .testTarget(
            name: "Example",
            dependencies: ["QKSliderView"]),
    ]
)
