//
//  RadioStation.swift
//
//  Created by Frank Gregor on 24.11.20.
//

import Foundation

public struct RadioStation {
    var stationUUID: String
    var name: String
    var url: String
    var urlResolved: String
    var homepage: String
    var icon: String
    var countryCode: String
    var state: String?
    var votes: Int
    var codec: String
    var bitrate: Int
    var supportsHLS: Int
    var clickCount: Int
    var lastChecked: Date
}

// MARK: - RadioStation+Codable

extension RadioStation: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case stationUUID   = "stationuuid"
        case name          = "name"
        case url           = "url"
        case urlResolved   = "url_resolved"
        case homepage      = "homepage"
        case icon          = "favicon"
        case countryCode   = "countrycode"
        case codec         = "codec"
        case lastChecked   = "lastchecktime"
        case supportsHLS   = "hls"
        case clickCount    = "clickcount"
        case votes         = "votes"
        case bitrate       = "bitrate"
    }
    
    public init(from decoder: Decoder) throws {
        let values    = try decoder.container(keyedBy: CodingKeys.self)
        stationUUID   = try values.decode(String.self, forKey: .stationUUID)
        name          = try values.decode(String.self, forKey: .name)
        url           = try values.decode(String.self, forKey: .url)
        urlResolved   = try values.decode(String.self, forKey: .urlResolved)
        homepage      = try values.decode(String.self, forKey: .homepage)
        icon          = try values.decode(String.self, forKey: .icon)
        countryCode   = try values.decode(String.self, forKey: .countryCode)
        codec         = try values.decode(String.self, forKey: .codec)
        lastChecked   = try values.decode(Date.self, forKey: .lastChecked)
        votes         = try values.decode(Int.self, forKey: .votes)
        bitrate       = try values.decode(Int.self, forKey: .bitrate)
        supportsHLS   = try values.decode(Int.self, forKey: .supportsHLS)
        clickCount    = try values.decode(Int.self, forKey: .clickCount)
    }

}

// MARK: - RadioStation+Hashable

extension RadioStation: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(stationUUID)
        hasher.combine(urlResolved)
    }
    
}

// MARK: - RadioStation+Equatable

extension RadioStation: Equatable {
    
    public static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
        return lhs.stationUUID == rhs.stationUUID &&
            lhs.urlResolved == rhs.urlResolved
    }
    
}
