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

internal protocol NetworkResource {
    associatedtype ModelType: Decodable
    var url: URL { get }
}

internal protocol ApiResource: NetworkResource {
    var endpoint: ApiEndpoints { get }
    var path: String? { get }
    var seconds: Int? { get }

    var name: String? { get }
    var nameExact: Bool? { get }
    var country: String? { get }
    var countryExact: Bool? { get }
    var countryCode: String? { get }
    var state: String? { get }
    var stateExact: Bool? { get }
    var language: String? { get }
    var languageExact: Bool? { get }
    var tag: String? { get }
    var tagExact: Bool? { get }
    var tagList: String? { get }
    var codec: String? { get }
    var bitrateMin: Int? { get }
    var bitrateMax: Int? { get }
    var hasGeoInfo: Bool? { get }
    var hasExtendedInfo: Bool? { get }
    var order: ApiResponseOrder? { get }
    var reverse: Bool? { get }
    var offset: Int? { get }
    var limit: Int? { get }
    var hideBroken: Bool? { get }
}

// MARK: - Default Values

extension ApiResource {
    var endpoint: ApiEndpoints { .stations }
    var hideBroken: Bool? { true }
}

extension ApiResource {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = RadioBrowser.apiServer.host
        components.path = "/\(RadioBrowser.apiResponseFormat.rawValue)/\(endpoint.rawValue)"
        components.queryItems = []

        if let path = path {
            components.path.append("/\(path)")
        }

        if let name = name {
            components.queryItems?.append(URLQueryItem(name: "name", value: name))
        }

        if let nameExact = nameExact,
           let name = name {
            if !name.isEmpty {
                components.queryItems?.append(URLQueryItem(name: "nameExact", value: nameExact.description))
            }
        }

        if let country = country {
            components.queryItems?.append(URLQueryItem(name: "country", value: country))
        }

        if let countryExact = countryExact,
           let country = country {
            if !country.isEmpty {
                components.queryItems?.append(URLQueryItem(name: "countryExact", value: countryExact.description))
            }
        }

        if let countryCode = countryCode {
            components.queryItems?.append(URLQueryItem(name: "countrycode", value: countryCode))
        }

        if let state = state {
            components.queryItems?.append(URLQueryItem(name: "state", value: state))
        }

        if let stateExact = stateExact,
           let state = state {
            if !state.isEmpty {
                components.queryItems?.append(URLQueryItem(name: "stateExact", value: stateExact.description))
            }
        }

        if let language = language {
            components.queryItems?.append(URLQueryItem(name: "language", value: language))
        }

        if let languageExact = languageExact,
           let language = language {
            if !language.isEmpty {
                components.queryItems?.append(URLQueryItem(name: "languageExact", value: languageExact.description))
            }
        }

        if let tag = tag {
            components.queryItems?.append(URLQueryItem(name: "tag", value: tag))
        }

        if let tagExact = tagExact,
           let tag = tag {
            if !tag.isEmpty {
                components.queryItems?.append(URLQueryItem(name: "tagExact", value: tagExact.description))
            }
        }

        if let tagList = tagList {
            components.queryItems?.append(URLQueryItem(name: "tagList", value: tagList))
        }

        if let codec = codec {
            components.queryItems?.append(URLQueryItem(name: "codec", value: codec))
        }

        if let bitrateMin = bitrateMin {
            components.queryItems?.append(URLQueryItem(name: "bitrateMin", value: bitrateMin.description))
        }

        if let bitrateMax = bitrateMax {
            components.queryItems?.append(URLQueryItem(name: "bitrateMax", value: bitrateMax.description))
        }

        if let hasGeoInfo = hasGeoInfo {
            components.queryItems?.append(URLQueryItem(name: "has_geo_info", value: hasGeoInfo.description))
        }

        if let hasExtendedInfo = hasExtendedInfo {
            components.queryItems?.append(URLQueryItem(name: "has_extended_info", value: hasExtendedInfo.description))
        }

        if let order = order {
            components.queryItems?.append(URLQueryItem(name: "order", value: order.rawValue))
        }

        if let reverse = reverse {
            components.queryItems?.append(URLQueryItem(name: "reverse", value: reverse.description))
        }

        if let offset = offset {
            components.queryItems?.append(URLQueryItem(name: "offset", value: offset.description))
        }

        if let limit = limit {
            components.queryItems?.append(URLQueryItem(name: "limit", value: limit.description))
        }

        if let hidebroken = hideBroken {
            components.queryItems?.append(URLQueryItem(name: "hidebroken", value: hidebroken.description))
        }

        if let seconds = seconds {
            components.queryItems?.append(URLQueryItem(name: "seconds", value: seconds.description))
        }

        return components.url!
    }
}
