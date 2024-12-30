//
//  File 2.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 20/09/2024.
//

@preconcurrency import StripeKit
import Coenttb_Web

public enum StripeClientKey {
    
}

extension StripeClientKey: TestDependencyKey {
    public static let testValue: Coenttb_Stripe.Client? = .init(
        client: .init(httpClient: .testValue, apiKey: "test"),
        prices: .init(),
        customers: .init(),
        subscriptions: .init(),
        invoices: .init(),
        paymentIntents: .init(),
        portalSession: .init()
    )
}

extension DependencyValues {
    public var stripe: Coenttb_Stripe.Client? {
        get { self[StripeClientKey.self] }
        set { self[StripeClientKey.self] = newValue }
    }
}
