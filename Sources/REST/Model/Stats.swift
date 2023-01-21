import Foundation

extension RadioBrowser {
    public struct Stats {
        public var supportedVersion: Int
        public var softwareVersion: String
        public var status: String
        public var stations: Int
        public var stationsBroken: Int
        public var tags: Int
        public var clicksLastHour: Int
        public var clicksLastDay: Int
        public var languages: Int
        public var countries: Int

    }
}

extension RadioBrowser.Stats: Decodable {
    private enum CodingKeys: String, CodingKey {
        case supportedVersion = "supported_version"
        case softwareVersion  = "software_version"
        case status
        case stations
        case stationsBroken   = "stations_broken"
        case tags
        case clicksLastHour   = "clicks_last_hour"
        case clicksLastDay    = "clicks_last_day"
        case languages
        case countries
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        supportedVersion = try container.decode(Int.self, forKey: .supportedVersion)
        softwareVersion  = try container.decode(String.self, forKey: .softwareVersion)
        status           = try container.decode(String.self, forKey: .status)
        stations         = try container.decode(Int.self, forKey: .stations)
        stationsBroken   = try container.decode(Int.self, forKey: .stationsBroken)
        tags             = try container.decode(Int.self, forKey: .tags)
        clicksLastHour   = try container.decode(Int.self, forKey: .clicksLastHour)
        clicksLastDay    = try container.decode(Int.self, forKey: .clicksLastDay)
        languages        = try container.decode(Int.self, forKey: .languages)
        countries        = try container.decode(Int.self, forKey: .countries)
    }
}
