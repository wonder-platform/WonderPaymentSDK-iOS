//
//  AdItem.swift
//  WonderPaymentSDK
//
//  Created by X on 2024/7/18.
//

import Foundation

struct AdItem : JSONDecodable,JSONEncodable {
    
    let targetLink: String?
    let displayUrl: String
    let displayType: DisplayType
    
    static func from(json: NSDictionary?) -> AdItem {
        let targetLink = json?["target_link"] as? String
        let displayUrl = json?["display_url"] as? String ?? ""
        let typeValue = json?["display_type"] as? String ?? ""
        let displayType = DisplayType(rawValue: typeValue) ?? .image
        return AdItem(targetLink: targetLink, displayUrl: displayUrl, displayType: displayType)
    }
    
    func toJson() -> Dictionary<String, Any?> {
        return [
            "target_link":targetLink,
            "display_url": displayUrl,
            "display_type": displayType.rawValue
        ]
    }
    
    enum DisplayType: String {
        case image = "Image"
        case url = "Url"
        case video = "Video"
    }
}
