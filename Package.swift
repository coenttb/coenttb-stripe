// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let coenttbStripe: Self = "Coenttb Stripe"
    static let coenttbStripeLive: Self = "Coenttb Stripe Live"
}

extension Target.Dependency {
    static var coenttbStripe: Self { .target(name: .coenttbStripe) }
    static var coenttbStripeLive: Self { .target(name: .coenttbStripeLive) }
}

extension Target.Dependency {
    static var coenttbWeb: Self { .product(name: "Coenttb Web", package: "coenttb-web") }
    static var coenttbServer: Self { .product(name: "Coenttb Server", package: "coenttb-server") }
    static var foundationPrelude: Self { .product(name: "FoundationPrelude", package: "coenttb-server") }
    static var dependenciesMacros: Self { .product(name: "DependenciesMacros", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var vaporCommunityStripeKit: Self { .product(name: "StripeKit", package: "stripe-kit") }
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
        .package(url: "https://github.com/coenttb/coenttb-server.git", branch: "main"),
        .package(url: "https://github.com/coenttb/pointfree-server.git", branch: "main"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.1.5"),
        .package(url: "https://github.com/vapor-community/stripe-kit.git", from: "25.0.0"),
    ],
    targets: [
        .target(
            name: .coenttbStripe,
            dependencies: [
                .coenttbWeb,
                .foundationPrelude,
                .dependenciesMacros,
                .vaporCommunityStripeKit
            ]
        ),
        .target(
            name: .coenttbStripeLive,
            dependencies: [
                .coenttbStripe,
                .coenttbWeb,
                .coenttbServer,
                .vaporCommunityStripeKit
            ]
        ),
        .testTarget(
            name: .coenttbStripe + " Tests",
            dependencies: [
                .coenttbStripe,
                .coenttbStripeLive,
                .dependenciesTestSupport
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
