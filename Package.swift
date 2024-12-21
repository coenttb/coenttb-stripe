// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let coenttbStripe: Self = "CoenttbStripe"
    static let coenttbStripeLive: Self = "CoenttbStripeLive"
}

extension Target.Dependency {
    static var coenttbStripe: Self { .target(name: .coenttbStripe) }
    static var coenttbStripeLive: Self { .target(name: .coenttbStripeLive) }
}

extension Target.Dependency {
    static var coenttbWeb: Self { .product(name: "CoenttbWeb", package: "coenttb-web") }
    static var dependenciesMacros: Self { .product(name: "DependenciesMacros", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var codable: Self { .product(name: "MacroCodableKit", package: "macro-codable-kit") }
    static var fluent: Self { .product(name: "Fluent", package: "fluent") }
    static var vaporCommunityStripeKit: Self { .product(name: "StripeKit", package: "stripe-kit") }
    static var memberwiseInit: Self { .product(name: "MemberwiseInit", package: "swift-memberwise-init-macro") }
}

let package = Package(
    name: "coenttb-stripe",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: .coenttbStripe, targets: [.coenttbStripe]),
        .library(name: .coenttbStripeLive, targets: [.coenttbStripeLive]),
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/coenttb-web.git", branch: "main"),
        .package(url: "https://github.com/coenttb/macro-codable-kit.git", branch: "main"),
        .package(url: "https://github.com/gohanlon/swift-memberwise-init-macro.git", from: "0.5.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.1.5"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.102.1"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        .package(url: "https://github.com/vapor-community/stripe-kit.git", from: "25.0.0"),
    ],
    targets: [
        .target(
            name: .coenttbStripe,
            dependencies: [
                .memberwiseInit,
                .coenttbWeb,
                .codable,
                .dependenciesMacros,
                .vaporCommunityStripeKit
            ]
        ),
        .target(
            name: .coenttbStripeLive,
            dependencies: [
                .coenttbWeb,
                .coenttbStripe,
                .vaporCommunityStripeKit
            ]
        ),
        .testTarget(
            name: .coenttbStripe + " Tests",
            dependencies: [
                .coenttbStripe,
                .dependenciesTestSupport
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
