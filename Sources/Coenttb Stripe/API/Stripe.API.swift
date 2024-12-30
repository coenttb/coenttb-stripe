//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 20/09/2024.
//

import Coenttb_Web

public enum API: Equatable, Sendable {
    case payment_intent(Coenttb_Stripe.API.PaymentIntent)
    case subscription(Coenttb_Stripe.API.Subscription)
    case publishableKey
}

extension Coenttb_Stripe.API {
    public struct Router: ParserPrinter, Sendable {
        
        public init(){}
        
        public var body: some URLRouting.Router<Coenttb_Stripe.API> {
            OneOf {
                URLRouting.Route(.case(Coenttb_Stripe.API.publishableKey)) {
                    Path { "publishable-key" }
                }
                
                URLRouting.Route(.case(Coenttb_Stripe.API.payment_intent)) {
                    Path { "payment-intent" }
                    Coenttb_Stripe.API.PaymentIntent.Router()
                }
                                
                URLRouting.Route(.case(Coenttb_Stripe.API.subscription)) {
                    Path { "subscription" }
                    Coenttb_Stripe.API.Subscription.Router()
                }
            }
        }
    }
}
