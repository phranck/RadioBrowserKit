//
//  RadioStation.swift
//
//  Created by Frank Gregor on 24.11.20.
//

import Foundation
//import RealmSwift

public struct RadioStation: Codable, Equatable {

    var stationUUID: String = ModelDefaults.EmptyString
    var name: String        = ModelDefaults.EmptyString
    var url: String         = ModelDefaults.EmptyString
    var streamUrl: String   = ModelDefaults.EmptyString
    var website: String     = ModelDefaults.EmptyString
    var icon: String        = ModelDefaults.EmptyString
    var countryCode: String = ModelDefaults.EmptyString
    var codec: String       = ModelDefaults.EmptyString
    var supportsHLS: Int    = 0
    var clickCount: Int     = 0
    var votes: Int          = 0
    var bitrate: Int        = 0
    
    private enum CodingKeys: String, CodingKey {
        case stationUUID   = "stationuuid"
        case name          = "name"
        case streamUrl     = "url_resolved"
        case website       = "homepage"
        case icon          = "favicon"
        case countryCode   = "countrycode"
        case codec         = "codec"
        case supportsHLS   = "hls"
        case clickCount    = "clickcount"
        case votes         = "votes"
        case bitrate       = "bitrate"
    }
    
    public static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
        return lhs.stationUUID == rhs.stationUUID
    }

}
//
//public class RadioStation: Object, Codable {
//    var stationUUID: String = ModelDefaults.EmptyString
//    var name: String        = ModelDefaults.EmptyString
//    var url: String         = ModelDefaults.EmptyString
//    var streamUrl: String   = ModelDefaults.EmptyString
//    var website: String     = ModelDefaults.EmptyString
//    var icon: String        = ModelDefaults.EmptyString
//    var countryCode: String = ModelDefaults.EmptyString
//    var codec: String       = ModelDefaults.EmptyString
//    var supportsHLS: Int    = 0
//    var clickCount: Int     = 0
//    var votes: Int          = 0
//    var bitrate: Int        = 0
//
//    private enum CodingKeys: String, CodingKey {
//        case stationUUID   = "stationuuid"
//        case name          = "name"
//        case streamUrl     = "url_resolved"
//        case website       = "homepage"
//        case icon          = "favicon"
//        case countryCode   = "countrycode"
//        case codec         = "codec"
//        case supportsHLS   = "hls"
//        case clickCount    = "clickcount"
//        case votes         = "votes"
//        case bitrate       = "bitrate"
//    }
//
//    public override static func primaryKey() -> String? {
//        return "stationUUID"
//    }
//
//    convenience required public init(from decoder: Decoder) throws {
//        self.init()
//
//        let values    = try decoder.container(keyedBy: CodingKeys.self)
//
//        stationUUID   = try values.decode(String.self, forKey: .stationUUID)
//        name          = try values.decode(String.self, forKey: .name)
//        streamUrl     = try values.decode(String.self, forKey: .streamUrl)
//        website       = try values.decode(String.self, forKey: .website)
//        icon          = try values.decode(String.self, forKey: .icon)
//        countryCode   = try values.decode(String.self, forKey: .countryCode)
//        codec         = try values.decode(String.self, forKey: .codec)
//        supportsHLS   = try values.decode(Int.self, forKey: .supportsHLS)
//        clickCount    = try values.decode(Int.self, forKey: .clickCount)
//        votes         = try values.decode(Int.self, forKey: .votes)
//        bitrate       = try values.decode(Int.self, forKey: .bitrate)
//    }
//}
