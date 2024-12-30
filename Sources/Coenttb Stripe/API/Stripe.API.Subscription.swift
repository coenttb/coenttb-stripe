//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 17/09/2024.
//


import Coenttb_Web

extension API {
    public enum Subscription: Equatable, Sendable {
        case config
        case invoicePreview(InvoicePreview)
        case update(Update)
        case subscriptions
        case cancel(Cancel)
        case create(Create)
    }
}

extension API.Subscription {
    public struct InvoicePreview: Codable, Hashable, Sendable {
        public let subscriptionId: String
        public let newPriceId: String
        
        public init(
            subscriptionId: String = "",
            newPriceId: String = ""
        ) {
            self.subscriptionId = subscriptionId
            self.newPriceId = newPriceId
        }
        
        public enum CodingKeys: String, CodingKey {
            case subscriptionId
            case newPriceId
        }
    }
}

extension API.Subscription {
    public struct Update: Codable, Hashable, Sendable {
        public let subscriptionId: String
        public let newPriceId: String
        
        public init(
            subscriptionId: String,
            newPriceId: String
        ) {
            self.subscriptionId = subscriptionId
            self.newPriceId = newPriceId
        }
        
        public enum CodingKeys: String, CodingKey {
            case subscriptionId
            case newPriceId
        }
    }
}

extension API.Subscription {
    public struct Create: Codable, Hashable, Sendable {
        public let priceId: String
        public let name: String
        
        public init(
            priceId: String = "",
            name: String = ""
        ) {
            self.priceId = priceId
            self.name = name
        }
        
        public enum CodingKeys: String, CodingKey {
            case priceId
            case name
        }
    }
}

extension API.Subscription {
    public struct Cancel: Codable, Hashable, Sendable {
        public let subscriptionId: String
        
        public init(
            subscriptionId: String = ""
        ) {
            self.subscriptionId = subscriptionId
        }
        
        public enum CodingKeys: String, CodingKey {
            case subscriptionId
        }
    }
}

extension API.Subscription {
    public struct Router: ParserPrinter {
        public init(){}
        
        public var body: some URLRouting.Router<API.Subscription> {
            OneOf {
                URLRouting.Route(.case(API.Subscription.config)) {
                    Path { "config" }
                }
                
                URLRouting.Route(.case(API.Subscription.invoicePreview)) {
                    Method.get
                    Path { "invoice-preview" }
                    Parse(.memberwise(API.Subscription.InvoicePreview.init)) {
                        Query {
                            Field(API.Subscription.InvoicePreview.CodingKeys.subscriptionId.rawValue, .string)
                            Field(API.Subscription.InvoicePreview.CodingKeys.newPriceId.rawValue, .string)
                        }
                    }
                }
                
                URLRouting.Route(.case(API.Subscription.update)) {
                    Method.post
                    Path { "update-subscription" }
                    Parse(.memberwise(API.Subscription.Update.init)) {
                        Query {
                            Field(API.Subscription.Update.CodingKeys.subscriptionId.rawValue, .string)
                            Field(API.Subscription.Update.CodingKeys.newPriceId.rawValue, .string)
                        }
                    }
                }
                
                URLRouting.Route(.case(API.Subscription.cancel)) {
                    Method.post
                    Path { "cancel-subscription" }
                    Parse(.memberwise(API.Subscription.Cancel.init)) {
                        Query {
                            Field(API.Subscription.Cancel.CodingKeys.subscriptionId.rawValue, .string)
                        }
                    }
                }
                
                URLRouting.Route(.case(API.Subscription.subscriptions)) {
                    Path { "subscriptions" }
                }
                
                URLRouting.Route(.case(API.Subscription.create)) {
                    Method.post
                    Path { "create-subscription" }
                    Body(.form(API.Subscription.Create.self, decoder: .default))
                }
            }
        }
    }
}


extension UrlFormDecoder {
    fileprivate static var `default`: UrlFormDecoder  {
        let decoder = UrlFormDecoder()
        decoder.parsingStrategy = .bracketsWithIndices
        return decoder
    }
}
