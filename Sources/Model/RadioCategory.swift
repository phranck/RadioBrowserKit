//
//  Created by Frank Gregor on 04.06.21.
//

import Foundation

public struct RadioCategory: Hashable, Identifiable {
    public var id: String = UUID().uuidString
    public var key: String
    public var type: String
    public var text: String
    public var url: String
}

extension RadioCategory: Codable {

    private enum CodingKeys: String, CodingKey {
        case key  = "key"
        case type = "type"
        case text = "text"
        case url  = "URL"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(key, forKey: .key)
        try container.encode(type, forKey: .type)
        try container.encode(text, forKey: .text)
        try container.encode(url, forKey: .url)
    }

}

extension RadioCategory: Equatable {

    public static func == (lhs: RadioCategory, rhs: RadioCategory) -> Bool {
        return lhs.id == rhs.id
    }

}
