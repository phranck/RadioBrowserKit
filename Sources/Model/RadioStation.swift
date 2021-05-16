//
//  RadioStation.swift
//
//  Created by Frank Gregor on 24.11.20.
//

import Foundation

public struct RadioStation: Identifiable {
    
    public var id: String
    public var name: String
    public var streamUrl: String
    public var website: String?
    public var icon: String?
    public var countryCode: String
    public var codec: String?
    public var clickCount: Int
    public var votes: Int
    public var bitrate: Int

}

extension RadioStation: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id            = "stationuuid"
        case name          = "name"
        case streamUrl     = "url_resolved"
        case website       = "homepage"
        case icon          = "favicon"
        case countryCode   = "countrycode"
        case codec         = "codec"
        case clickCount    = "clickcount"
        case votes         = "votes"
        case bitrate       = "bitrate"
    }

}

extension RadioStation: Equatable {
    
    public static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
        return lhs.id == rhs.id
    }

}
