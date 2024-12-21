//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 10/09/2024.
//

import CoenttbStripe
import CoenttbWebHTML
import CoenttbStripe
import Dependencies
import Fluent
import Foundation
import Languages
import Vapor

extension CoenttbStripe.API {
    public static func response(
        stripe: CoenttbStripe.API,
        publishableKey: String,
        productLookupKeys: String,
        currentUserStripeCustomerId: @escaping () -> String?,
        subscriber_email: @escaping () -> String?,
        subscriber_name: @escaping () -> String?,
        updateUser: (_ stripeCustomerId: String) async throws -> Void,
        checkIfStripeCustomerIdAlreadyExists: () async throws -> String?
    ) async throws -> any AsyncResponseEncodable {
        switch stripe {
        case let .subscription(subscription):
            return try await CoenttbStripe.API.Subscription.response(
                publishableKey: publishableKey,
                productLookupKeys: [productLookupKeys],
                currentUserStripeCustomerId: currentUserStripeCustomerId,
                subscriber_email: subscriber_email,
                subscriber_name: subscriber_name,
                updateUser: updateUser,
                checkIfStripeCustomerIdAlreadyExists: checkIfStripeCustomerIdAlreadyExists,
                subscription: subscription
            )
            
        case .publishableKey:
            return ["publishableKey": publishableKey]

        case let .payment_intent(payment_intent):
            return try await CoenttbStripe.API.PaymentIntent.response(payment_intent: payment_intent)
        }
    }
}
