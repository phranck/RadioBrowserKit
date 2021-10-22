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
import Regex

public struct Station: Decodable, Identifiable {
    public var id: String { stationUUID }
    public var changeUUID: String
    public var stationUUID: String
    public var name: String

    private var streamUrlString: String
    public var streamUrl: URL {
        URL(string: streamUrlString)!
    }

    private var streamUrlStringResolved: String
    public var streamUrlResolved: URL {
        URL(string: streamUrlStringResolved)!
    }

    public var websiteUrlString: String = ""
    public var websiteUrl: URL? {
        URL(string: websiteUrlString)
    }

    private var coverUrlString: String
    public var coverUrl: URL? {
        return URL(string: coverUrlString)
    }

    public var tags: String
    public var countryCode: String
    public var state: String
    public var language: String
    public var languageCodes: String
    public var votes: Int

    private var lastChangeTime_ISO8601: String
    public var lastChangeTime: Date {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: lastChangeTime_ISO8601) {
            return date
        }
        return Date()
    }

    public var codec: String
    public var bitrate: Int
    public var hls: Bool
    public var lastCheckOk: Bool

    private var lastCheckTime_ISO8601: String
    public var lastCheckTime: Date {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: lastCheckTime_ISO8601) {
            return date
        }
        return Date()
    }

    private var lastCheckOkTime_ISO8601: String
    public var lastCheckOkTime: Date {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: lastCheckOkTime_ISO8601) {
            return date
        }
        return Date()
    }

    private var lastLocalCheckTime_ISO8601: String
    public var lastLocalCheckTime: Date {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: lastLocalCheckTime_ISO8601) {
            return date
        }
        return Date()
    }

    private var lastClickTime_ISO8601: String?
    public var lastClickTime: Date {
        let dateFormatter = ISO8601DateFormatter()
        if let str = lastClickTime_ISO8601,
           let date = dateFormatter.date(from: str) {
            return date
        }
        return Date()
    }

    public var clickCount: Int
    public var clickTrend: Int
    public var sslError: Bool
    public var latitude: Double?
    public var longitude: Double?
    public var hasExtendedInfo: Bool?

    private enum CodingKeys: String, CodingKey {
        case changeUUID                 = "changeuuid"
        case stationUUID                = "stationuuid"
        case serverUUID                 = "serveruuid"
        case name                       = "name"
        case streamUrlString            = "url"
        case streamUrlStringResolved    = "url_resolved"
        case websiteUrlString           = "homepage"
        case coverUrlString             = "favicon"
        case tags                       = "tags"
        case countryCode                = "countrycode"
        case state                      = "state"
        case language                   = "language"
        case languageCodes              = "languagecodes"
        case votes                      = "votes"
        case lastChangeTime             = "lastchangetime"
        case lastChangeTime_ISO8601     = "lastchangetime_iso8601"
        case codec                      = "codec"
        case bitrate                    = "bitrate"
        case hls                        = "hls"
        case lastCheckOk                = "lastcheckok"
        case lastCheckTime              = "lastchecktime"
        case lastCheckTime_ISO8601      = "lastchecktime_iso8601"
        case lastCheckOkTime            = "lastcheckoktime"
        case lastCheckOkTime_ISO8601    = "lastcheckoktime_iso8601"
        case lastLocalCheckTime         = "lastlocalchecktime"
        case lastLocalCheckTime_ISO8601 = "lastlocalchecktime_iso8601"
        case lastClickTime              = "clicktimestamp"
        case lastClickTime_ISO8601      = "clicktimestamp_iso8601"
        case clickCount                 = "clickcount"
        case clickTrend                 = "clicktrend"
        case sslError                   = "ssl_error"
        case latitude                   = "geo_lat"
        case longitude                  = "geo_long"
        case hasExtendedInfo            = "has_extended_info"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Unfortunately, the open architecture Radio Browser suffers from heavy littering!
        // There are lots of duplicates and a proliferation of station names. It needs a bit of tidying up.
        name = try container.decode(String.self, forKey: .name)
            .replacingFirst(matching: "(.+) (\\d{1,3}\\.\\d{1}) (\\(.+\\))", with: "$1")
            .replacingFirst(matching: "(.+) (\\(.+\\))", with: "$1")
            .replacingFirst(matching: "(.+) (\\[.+\\])", with: "$1")
            .replacingFirst(matching: "(- 0 N -) (.+)", with: "$2")
            .replacingFirst(matching: "(.+(on Radio ON))(.+)", with: "$1")
            .replacingFirst(matching: "(RADIO (BOB\\!)) (BOBs (.+))", with: "$2 $4")
            .replacingFirst(matching: "(Radio|RADIO) (BOB\\!) (.+)", with: "$2 $3")

        changeUUID = try container.decode(String.self, forKey: .changeUUID)
        stationUUID = try container.decode(String.self, forKey: .stationUUID)
        streamUrlString = try container.decode(String.self, forKey: .streamUrlString)
        streamUrlStringResolved = try container.decode(String.self, forKey: .streamUrlStringResolved)
        websiteUrlString = try container.decode(String.self, forKey: .websiteUrlString)
        coverUrlString = try container.decode(String.self, forKey: .coverUrlString)
        tags = try container.decode(String.self, forKey: .tags)
        countryCode = try container.decode(String.self, forKey: .countryCode)
        state = try container.decode(String.self, forKey: .state)
        language = try container.decode(String.self, forKey: .language)
        languageCodes = try container.decode(String.self, forKey: .languageCodes)
        votes = try container.decode(Int.self, forKey: .votes)
        lastChangeTime_ISO8601 = try container.decode(String.self, forKey: .lastChangeTime_ISO8601)
        codec = try container.decode(String.self, forKey: .codec)
        bitrate = try container.decode(Int.self, forKey: .bitrate)

        let hlsDecoded = try container.decode(Int.self, forKey: .hls)
        hls = hlsDecoded.boolValue

        let lastCheckOkDecoded = try container.decode(Int.self, forKey: .lastCheckOk)
        lastCheckOk = lastCheckOkDecoded.boolValue

        lastCheckTime_ISO8601 = try container.decode(String.self, forKey: .lastCheckTime_ISO8601)
        lastCheckOkTime_ISO8601 = try container.decode(String.self, forKey: .lastCheckOkTime_ISO8601)
        lastLocalCheckTime_ISO8601 = try container.decode(String.self, forKey: .lastLocalCheckTime_ISO8601)
        lastClickTime_ISO8601 = try container.decodeIfPresent(String.self, forKey: .lastClickTime_ISO8601)

        clickCount = try container.decode(Int.self, forKey: .clickCount)
        clickTrend = try container.decode(Int.self, forKey: .clickTrend)

        let sslErrorDecoded = try container.decode(Int.self, forKey: .sslError)
        sslError = sslErrorDecoded.boolValue

        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        hasExtendedInfo = try container.decodeIfPresent(Bool.self, forKey: .hasExtendedInfo)
    }
}

extension Station: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(changeUUID, forKey: .changeUUID)
        try container.encode(stationUUID, forKey: .stationUUID)
        try container.encode(name, forKey: .name)
        try container.encode(streamUrlString, forKey: .streamUrlString)
        try container.encode(streamUrlStringResolved, forKey: .streamUrlStringResolved)
        try container.encode(websiteUrlString, forKey: .websiteUrlString)
        try container.encode(coverUrlString, forKey: .coverUrlString)
        try container.encode(tags, forKey: .tags)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(state, forKey: .state)
        try container.encode(language, forKey: .language)
        try container.encode(languageCodes, forKey: .languageCodes)
        try container.encode(votes, forKey: .votes)
        try container.encode(lastChangeTime_ISO8601, forKey: .lastChangeTime_ISO8601)
        try container.encode(codec, forKey: .codec)
        try container.encode(bitrate, forKey: .bitrate)
        try container.encode(hls.intValue, forKey: .hls)
        try container.encode(lastCheckOk.intValue, forKey: .lastCheckOk)
        try container.encode(lastCheckTime_ISO8601, forKey: .lastCheckTime_ISO8601)
        try container.encode(lastCheckOkTime_ISO8601, forKey: .lastCheckOkTime_ISO8601)
        try container.encode(lastLocalCheckTime_ISO8601, forKey: .lastLocalCheckTime_ISO8601)
        try container.encodeIfPresent(lastClickTime_ISO8601, forKey: .lastClickTime_ISO8601)
        try container.encode(clickCount, forKey: .clickCount)
        try container.encode(clickTrend, forKey: .clickTrend)
        try container.encode(sslError.intValue, forKey: .sslError)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encodeIfPresent(hasExtendedInfo, forKey: .hasExtendedInfo)
    }
}

extension Station: Equatable {
    public static func == (lhs: Station, rhs: Station) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Station: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Int {
    var boolValue: Bool { return self != 0 }
}

extension Bool {
    var intValue: Int { return self ? 1 : 0 }
}
