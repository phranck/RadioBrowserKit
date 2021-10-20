//
//  File.swift
//  
//
//  Created by Frank Gregor on 19.10.21.
//

import Foundation

public class ClickCount: Codable {
    public var ok: Bool
    public var message: String
    public var stationUUID: String
    public var name: String
    private var urlString: String
    public var url: URL {
        URL(string: urlString)!
    }

    private enum CodingKeys: String, CodingKey {
        case ok
        case message
        case stationUUID = "stationuuid"
        case name
        case urlString = "url"
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        ok = try container.decode(Bool.self, forKey: .ok)
        message = try container.decode(String.self, forKey: .message)
        stationUUID = try container.decode(String.self, forKey: .stationUUID)
        name = try container.decode(String.self, forKey: .name)
        urlString = try container.decode(String.self, forKey: .urlString)
    }
}
