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

import CoreLocation
import Foundation
import Regex

/**
 Object which represents a radio station of the Radio Browser API.

 ```json
 [
     {
         "changeuuid": "17142cad-4faf-11e9-a4d7-52543be04c81",
         "stationuuid": "17142ca0-4faf-11e9-a4d7-52543be04c81",
         "serveruuid": "cab9cde6-4922-475a-bdb4-ff681d25b2c6",
         "name": "CITY23",
         "url": "http://live.radiomax.technology/city23",
         "url_resolved": "http://live.radiomax.technology/city23",
         "homepage": "http://city23.at/",
         "favicon": "http://city23.at/img/Logo_BCL.png",
         "tags": "dab+,easy listening",
         "country": "Austria",
         "countrycode": "AT",
         "iso_3166_2": null,
         "state": "Vienna",
         "language": "german",
         "languagecodes": "de",
         "votes": 25,
         "lastchangetime": "2021-08-06 08:36:44",
         "lastchangetime_iso8601": "2021-08-06T08:36:44Z",
         "codec": "MP3",
         "bitrate": 192,
         "hls": 0,
         "lastcheckok": 1,
         "lastchecktime": "2021-10-22 22:09:29",
         "lastchecktime_iso8601": "2021-10-22T22:09:29Z",
         "lastcheckoktime": "2021-10-22 22:09:29",
         "lastcheckoktime_iso8601": "2021-10-22T22:09:29Z",
         "lastlocalchecktime": "2021-10-22 22:09:29",
         "lastlocalchecktime_iso8601": "2021-10-22T22:09:29Z",
         "clicktimestamp": "2021-10-23 09:23:27",
         "clicktimestamp_iso8601": "2021-10-23T09:23:27Z",
         "clickcount": 4,
         "clicktrend": 3,
         "ssl_error": 0,
         "geo_lat": null,
         "geo_long": null,
         "has_extended_info": false
     }
 ]
 ```
 */
public struct Station: Decodable, Identifiable {
    /// A globally unique identifier for the station. Same as `stationUUID`. (read only)
    public var id: String { stationUUID }

    /// A globally unique identifier for the change of the station information.
    public var changeUUID: String
    /// A globally unique identifier for the station.
    public var stationUUID: String
    /// The name of the station
    public var name: String

    private var streamUrlString: String
    /// The stream URL provided by the user.
    public var streamUrl: URL {
        URL(string: streamUrlString)!
    }

    private var streamUrlStringResolved: String
    /// An automatically "resolved" stream URL. Things resolved are playlists (M3U/PLS/ASX...), HTTP redirects (Code 301/302). This link is especially usefull if you use this API from a platform that is not able to do a resolve on its own (e.g. JavaScript in browser) or you just don't want to invest the time in decoding playlists yourself.
    public var streamUrlResolved: URL {
        URL(string: streamUrlStringResolved)!
    }

    private var websiteUrlString: String = ""
    /// URL to the homepage of the stream, so you can direct the user to a page with more information about the stream.
    public var websiteUrl: URL? {
        URL(string: websiteUrlString)
    }

    private var coverUrlString: String
    /// URL to an icon or picture that represents the stream. (PNG, JPG).
    public var coverUrl: URL? {
        return URL(string: coverUrlString)
    }

    /// Tags of the stream with more information about it.
    public var tags: String
    /// Two letter, uppercase country code as described in [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).
    public var countryCode: String
    /// Full name of the entity where the station is located inside the country.
    public var state: String
    /// Languages that are spoken in this stream.<br>
    /// This is a multivalue parameter. If there are more than one language, it's a comma separated list.
    public var language: String
    /// Languages that are spoken in this stream by code [ISO 639-2/B](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).
    public var languageCodes: String
    /// Number of votes for this station. This number is by server and only ever increases. It will never be reset to 0.
    public var votes: Int

    private var lastChangeTime_ISO8601: String
    /// Last time when the stream information was changed in the database.
    public var lastChangeTime: Date {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: lastChangeTime_ISO8601) {
            return date
        }
        return Date()
    }

    /// The codec of this stream recorded at the last check.
    public var codec: String
    /// The bitrate of this stream recorded at the last check.
    public var bitrate: Int
    /// Boolean value which describes whether the station supports [HLS](https://en.wikipedia.org/wiki/HTTP_Live_Streaming) or or not.
    public var hls: Bool
    /// This value is calculated using several measurement points, as the backend servers of Radio Browser are located in different countries. The calculated value is a majority vote.
    public var lastCheckOk: Bool

    private var lastCheckTime_ISO8601: String
    /// The last time when any Radio Browser server checked the online state of this stream.
    public var lastCheckTime: Date {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: lastCheckTime_ISO8601) {
            return date
        }
        return Date()
    }

    private var lastCheckOkTime_ISO8601: String?
    /// The last time when the stream was checked for the online status with a positive result.
    public var lastCheckOkTime: Date {
        let dateFormatter = ISO8601DateFormatter()
        if let lastCheckTimeOk = lastCheckOkTime_ISO8601,
           let date = dateFormatter.date(from: lastCheckTimeOk) {
            return date
        }
        return Date()
    }

    private var lastLocalCheckTime_ISO8601: String
    /// The last time when this server checked the online state and the metadata of this stream.
    public var lastLocalCheckTime: Date {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: lastLocalCheckTime_ISO8601) {
            return date
        }
        return Date()
    }

    private var lastClickTime_ISO8601: String?
    /// The time when the last click has been recorded for this stream.
    public var lastClickTime: Date {
        let dateFormatter = ISO8601DateFormatter()
        if let str = lastClickTime_ISO8601,
           let date = dateFormatter.date(from: str) {
            return date
        }
        return Date()
    }

    /// Clicks within the last 24 hours. To increase this value, the developer sould call `RadioBrowser updateClickCount(for:completion)` every time a stream starts playing.
    public var clickCount: Int
    /// The difference of the clickcounts within the last 2 days. Posivite values mean an increase, negative a decrease of clicks.
    public var clickTrend: Int
    /// Boolean value which describes the connection result to stream over HTTPS. `true` means there were an error, `false` means no error.
    public var sslError: Bool
    private var latitude: Double?
    private var longitude: Double?
    /// Geo location on earth of the stream.
    public var geoLocation: CLLocation? {
        guard let latitude = latitude,
              let longitude = longitude else {
                  return nil
              }
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    /// Boolean value which describes whether the stream owner does provide extended information as HTTP headers (which override the information in the database) or not.
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
            .replacingFirst(matching: "(__(.+)__) (.+)", with: "$2")

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
        lastCheckOkTime_ISO8601 = try container.decodeIfPresent(String.self, forKey: .lastCheckOkTime_ISO8601)
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
        try container.encodeIfPresent(lastCheckOkTime_ISO8601, forKey: .lastCheckOkTime_ISO8601)
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

fileprivate extension Int {
    var boolValue: Bool { return self != 0 }
}

fileprivate extension Bool {
    var intValue: Int { return self ? 1 : 0 }
}
