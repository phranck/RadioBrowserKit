/*
 The MIT License (MIT)

 Copyright © 2021 Frank Gregor <phranck@woodbytes.me>

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the “Software”), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

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
