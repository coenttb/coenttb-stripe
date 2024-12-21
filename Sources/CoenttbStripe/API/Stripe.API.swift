//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 20/09/2024.
//

import Dependencies
import Foundation
import Languages
import URLRouting
import MacroCodableKit

public enum API: Equatable, Sendable {
    case payment_intent(CoenttbStripe.API.PaymentIntent)
    case subscription(CoenttbStripe.API.Subscription)
    case publishableKey
}

extension CoenttbStripe.API {
    public struct Router: ParserPrinter, Sendable {
        
        public init(){}
        
        public var body: some URLRouting.Router<CoenttbStripe.API> {
            OneOf {
                URLRouting.Route(.case(CoenttbStripe.API.publishableKey)) {
                    Path { "publishable-key" }
                }
                
                URLRouting.Route(.case(CoenttbStripe.API.payment_intent)) {
                    Path { "payment-intent" }
                    CoenttbStripe.API.PaymentIntent.Router()
                }
                                
                URLRouting.Route(.case(CoenttbStripe.API.subscription)) {
                    Path { "subscription" }
                    CoenttbStripe.API.Subscription.Router()
                }
            }
        }
    }
}
