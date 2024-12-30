//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 10/09/2024.
//

import Coenttb_Stripe
import Coenttb_Web
import Coenttb_Stripe
import Vapor

extension Coenttb_Stripe.API {
    public static func response(
        stripe: Coenttb_Stripe.API,
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
            return try await Coenttb_Stripe.API.Subscription.response(
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
            return try await Coenttb_Stripe.API.PaymentIntent.response(payment_intent: payment_intent)
        }
    }
}
