public class PaymentIntent : JSONDecodable, JSONEncodable {
    public var amount: Double
    public var currency: String
    public var orderNumber: String
    public var paymentMethod: PaymentMethod?
    public var transactionType: TransactionType = .sale
    public var lineItems: [LineItem]?
    
    public init(
        amount: Double,
        currency: String,
        orderNumber: String,
        paymentMethod: PaymentMethod? = nil,
        transactionType: TransactionType = .sale,
        lineItems: [LineItem]? = nil
    ) {
        self.amount = amount
        self.currency = currency
        self.orderNumber = orderNumber
        self.paymentMethod = paymentMethod
        self.transactionType = transactionType
        self.lineItems = lineItems
    }
    
    public func copy() -> PaymentIntent {
        return PaymentIntent(
            amount: self.amount,
            currency: self.currency,
            orderNumber: self.orderNumber,
            paymentMethod: self.paymentMethod,
            transactionType: self.transactionType,
            lineItems: self.lineItems?.map({$0.copy()})
        )
    }
    
    public static func from(json: NSDictionary?) -> Self {
        var paymentMethod: PaymentMethod?
        if let methodJson = json?["paymentMethod"] as? NSDictionary {
            paymentMethod = PaymentMethod.from(json: methodJson)
        }
        return PaymentIntent(
            amount: json?["amount"] as? Double ?? 0.0,
            currency: json?["currency"] as? String ?? "HKD",
            orderNumber: json?["orderNumber"] as? String ?? "",
            paymentMethod: paymentMethod,
            transactionType: TransactionType(rawValue: json?["transactionType"] as? String ?? "") ?? .sale,
            lineItems: LineItem.from(jsonArray: json?["lineItems"] as? NSArray)
        ) as! Self
    }
    
    func toJson() -> Dictionary<String, Any?> {
        return [
            "amount": amount,
            "currency": currency,
            "orderNumber": orderNumber,
            "paymentMethod": paymentMethod?.toJson(),
            "transactionType": transactionType.rawValue,
            "lineItems": lineItems?.map({$0.toJson()}),
        ]
    }
}
