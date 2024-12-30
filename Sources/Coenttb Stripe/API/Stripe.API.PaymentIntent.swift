//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 15/09/2024.
//


import Coenttb_Web

extension Coenttb_Stripe.API {
    public enum PaymentIntent: Equatable, Sendable {
        //        case cancel
        case create(Coenttb_Stripe.API.PaymentIntent.Create)
        //        case delete_discount
        //        case list
        //        case resume
        //        case retrieve
        //        case search
        //        case update
    }
}

extension Coenttb_Stripe.API.PaymentIntent {
    public struct Create: Codable, Hashable, Sendable {
        public let amount: Int
        
        public init(
            amount: Int = 0
        ) {
            self.amount = amount
        }
        
        public enum CodingKeys: String, CodingKey {
            case amount
        }
    }
}


extension Coenttb_Stripe.API.PaymentIntent {
    struct Router: ParserPrinter, Sendable {
        var body: some URLRouting.Router<API.PaymentIntent> {
            OneOf {
                URLRouting.Route(.case(API.PaymentIntent.create)) {
                    Path { "create" }
                    Parse(.memberwise(Coenttb_Stripe.API.PaymentIntent.Create.init)) {
                        Query {
                            Field(Coenttb_Stripe.API.PaymentIntent.Create.CodingKeys.amount.rawValue, default: 0) { Digits() }
                        }
                    }
                }
            }
        }
    }
}


//
//extension API.PaymentIntent {
//    public enum Create: Equatable {
//        case customer(API.PaymentIntent.Create.Customer)
//    }
//}
//
//extension API.PaymentIntent.Create {
//    struct Router: ParserPrinter, Sendable {
//        var body: some URLRouting.Router<API.PaymentIntent.Create> {
//            OneOf {
//                URLRouting.Route(.case(API.PaymentIntent.Create.customer)) {
//                    Method.post
//                    Path { "customer" }
//                    Body(.form(API.PaymentIntent.Create.Customer.self, decoder: .default))
//                }
//            }
//        }
//    }
//}
//
//extension API.PaymentIntent.Create {
//    @MemberwiseInit(.public)
//    @Codable
//    @CodingKeys(.kebab－case)
//    public struct Customer: Hashable {
//       @CodingKey("email")
//        @Init(default: "")
//        public let value: String
//    }
//}
//
//extension UrlFormDecoder {
//    fileprivate static let `default`: UrlFormDecoder = {
//        let decoder = UrlFormDecoder()
//        decoder.parsingStrategy = .bracketsWithIndices
//        return decoder
//    }()
//}
