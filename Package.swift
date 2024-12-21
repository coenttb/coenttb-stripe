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
    static var coenttbHtml: Self { .product(name: "CoenttbHTML", package: "coenttb-html") }
    static var coenttbMarkdown: Self { .product(name: "CoenttbMarkdown", package: "coenttb-html") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var dependenciesMacros: Self { .product(name: "DependenciesMacros", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var swiftDate: Self { .product(name: "Date", package: "swift-date") }
    static var language: Self { .product(name: "Languages", package: "swift-language") }
    static var logging: Self { .product(name: "Logging", package: "swift-log") }
    static var codable: Self { .product(name: "MacroCodableKit", package: "macro-codable-kit") }
    static var memberwiseInit: Self { .product(name: "MemberwiseInit", package: "swift-memberwise-init-macro") }
    static var environmentVariables: Self { .product(name: "EnvironmentVariables", package: "swift-environment-variables") }
    static var urlRouting: Self { .product(name: "URLRouting", package: "swift-url-routing") }
    static var either: Self { .product(name: "Either", package: "swift-prelude") }
    static var vapor: Self { .product(name: "Vapor", package: "Vapor") }
    static var coenttbVapor: Self { .product(name: "CoenttbVapor", package: "coenttb-web") }
    static var coenttbWebTranslations: Self { .product(name: "CoenttbWebTranslations", package: "coenttb-web") }
    static var coenttbWebHTML: Self { .product(name: "CoenttbWebHTML", package: "coenttb-web") }
    static var coenttbWebUtils: Self { .product(name: "CoenttbWebUtils", package: "coenttb-web") }
    static var coenttbEmail: Self { .product(name: "CoenttbEmail", package: "coenttb-html") }
    static var fluent: Self { .product(name: "Fluent", package: "fluent") }
    static var rateLimiter: Self { .product(name: "RateLimiter", package: "coenttb-utils") }
    static var urlFormCoding: Self { .product(name: "UrlFormCoding", package: "swift-web") }
    static var vaporCommunityStripeKit: Self { .product(name: "StripeKit", package: "stripe-kit") }
    static var coenttbWebDependencies: Self { .product(name: "CoenttbWebDependencies", package: "coenttb-web") }
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
        .package(url: "https://github.com/coenttb/coenttb-html.git", branch: "main"),
        .package(url: "https://github.com/coenttb/coenttb-web.git", branch: "main"),
        .package(url: "https://github.com/coenttb/coenttb-utils.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-date.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-environment-variables.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-language.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-web.git", branch: "main"),
        .package(url: "https://github.com/coenttb/macro-codable-kit.git", branch: "main"),
        .package(url: "https://github.com/gohanlon/swift-memberwise-init-macro.git", from: "0.3.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.1.5"),
        .package(url: "https://github.com/pointfreeco/swift-url-routing.git", from: "0.6.0"),
        .package(url: "https://github.com/pointfreeco/swift-prelude.git", from: "0.6.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.102.1"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        .package(url: "https://github.com/vapor-community/stripe-kit.git", from: "25.0.0"),
    ],
    targets: [
        .target(
            name: .coenttbStripe,
            dependencies: [
                .codable,
                .coenttbEmail,
                .coenttbHtml,
                .coenttbMarkdown,
                .coenttbWebTranslations,
                .coenttbWebUtils,
                .coenttbWebHTML,
                .dependencies,
                .dependenciesMacros,
                .either,
                .memberwiseInit,
                .language,
                .swiftDate,
                .urlRouting,
                .urlFormCoding,
                .vaporCommunityStripeKit,

            ]
        ),
        .target(
            name: .coenttbStripeLive,
            dependencies: [
                .coenttbStripe,
                .vapor,
                .dependencies,
                .coenttbWebUtils,
                .rateLimiter,
                .coenttbVapor,
                .vaporCommunityStripeKit,
                .coenttbWebDependencies,
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
