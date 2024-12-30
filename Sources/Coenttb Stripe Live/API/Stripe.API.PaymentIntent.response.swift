//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 15/09/2024.
//

import Coenttb_Stripe
import Coenttb_Web
import Vapor

extension Coenttb_Stripe.API.PaymentIntent {
    static func response(
        payment_intent: Coenttb_Stripe.API.PaymentIntent
    ) async throws -> any AsyncResponseEncodable {
        switch payment_intent {
        case let .create(create):
            @Dependency(\.stripe) var stripe

            guard let stripe
            else { throw Abort(.internalServerError) }
            
            let paymentIntent = try await stripe.paymentIntents.create(
                amount: create.amount,
                currency: .eur,
                automaticPaymentMethods: [ "enabled": true ]
            )

            if let clientSecret = paymentIntent.clientSecret {
                return ["clientSecret": clientSecret ]
            } else {
                throw Abort(.internalServerError, reason: "Failed to get client secret")
            }
        }
    }
}
