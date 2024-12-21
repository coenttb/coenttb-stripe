//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 15/09/2024.
//

import CoenttbStripe
import CoenttbWebHTML
import CoenttbStripe
import Dependencies
import Fluent
import Foundation
import Languages
import Mailgun
import Vapor

extension CoenttbStripe.API.PaymentIntent {
    static func response(
        payment_intent: CoenttbStripe.API.PaymentIntent
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
