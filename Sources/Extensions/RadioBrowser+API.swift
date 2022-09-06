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

extension RadioBrowserAPI {

    /**
      This call represents the [Advanced Station Search](https://de1.api.radio-browser.info/#Advanced_station_search) of Radio Browser.
      It returns a list of radio stations that match the search. It will search for the stations whose attributes contains the search term.

      - Parameters:
        - name: Name of the Radio Station. The given string will be used as a wildcard string. It doesn't have to match exactly, it's rather a "contains" search.
        - nameExact: Boolean value which tells the API that the given `name` must match exactly, otherwise all matches which contains the given `name` are responded. If `name` isn't given, this parameter will be ignored, too. Default value is `false`.
        - country: Country of the station.
        - countryExact: Boolean value which tells the API that the given `country` must match exactly, otherwise all matches which contains the given `country` are responded. If `country` isn't given, this parameter will be ignored, too. Default value is `false`.
        - countryCode: Two letter country code. See: [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).
        - state: State of the station.
        - stateExact: Boolean value which tells the API that the given `state` must match exactly, otherwise all matches which contains the given `state` are responded. If `state` isn't given, this parameter will be ignored, too. Default value is `false`.
        - language: Spoken language of the station
        - languageExact: Boolean value which tells the API that the given `language` must match exactly, otherwise all matches which contains the given `language` are responded. If `language` isn't given, this parameter will be ignored, too. Default value is `false`.
        - tag: A tag which is set for the station.
        - tagExact: Boolean value which tells the API that the given `tag` must match exactly, otherwise all matches which contains the given `tag` are responded. If `tag` isn't given, this parameter will be ignored, too. Default value is `false`.
        - tagList: A comma-separated list of tags. It can also be an array of string in JSON HTTP POST parameters. All tags in list have to match.
        - codec: The codec which is used by the station (e.g.: mp3, aac, ogg etc.). No default value is given.
        - bitrateMin: Tells the API to only return stations with a minimum bitrate of kb/s (kilobit per second). Must be a positive integer number. No default value is given.
        - bitrateMax: Tells the API to only return stations with a maximum bitrate of kb/s (kilobit per second). Must be a positive integer number. No default value is given.
        - hasGeoInfo: Since this boolean parameter is optional, it produces three different result sets.\n`nil` (or not set) returns all stations\n`false` returns all stations without geo information\n`true` returns all stations with geo information. No default value is given.
        - hasExtendedInfo: Since this boolean parameter is optional, it produces three different result sets.\n`nil` (or not set) returns all stations\n`false` returns all stations without extended information\n`true` returns all stations with extended information. No default value is given.
        - order: Tells the backend how to order the response. Available options are defined by the `ApiResponseOrder` parameter type. No default is given.
        - orderRevers: Tells the backend to reverse the requested order. Default is `false`.
        - offset: Offset from which the requested data set should start. Default is `0`.
        - limit: Number of items the API should respond, starting by `offset`. Default is `250`.
        - hideBroken: Tells the API whether to list or not list broken radio stations. `true` - list, `false` don't list. Default is `true`.
     */
    public func searchStations(
        withName name: String?,
        nameExact: Bool? = false,
        country: String?,
        countryExact: Bool? = false,
        countryCode: String?,
        state: String?,
        stateExact: Bool? = false,
        language: String?,
        languageExact: Bool? = false,
        tag: String?,
        tagExact: Bool? = false,
        tagList: String?,
        codec: String?,
        bitrateMin: Int?,
        bitrateMax: Int?,
        hasGeoInfo: Bool?,
        hasExtendedInfo: Bool?,
        order: ApiResponseOrder?,
        orderRevers: Bool? = false,
        offset: Int? = 0,
        limit: Int? = 250,
        hideBroken: Bool? = true
    ) {
        let request = StationRequest(api: self)
        request.search(
            name: name,
            nameExact: nameExact,
            country: country,
            countryExact: countryExact,
            countryCode: countryCode,
            state: state,
            stateExact: stateExact,
            language: language,
            languageExact: languageExact,
            tag: tag,
            tagExact: tagExact,
            tagList: tagList,
            codec: codec,
            bitrateMin: bitrateMin,
            bitrateMax: bitrateMax,
            hasGeoInfo: hasGeoInfo,
            hasExtendedInfo: hasExtendedInfo,
            order: order,
            reverse: orderRevers,
            offset: offset,
            limit: limit,
            hideBroken: hideBroken
        )
    }

    /**
      This call is part of the [List of radio stations](https://de1.api.radio-browser.info/#List_of_radio_stations) collection of Radio Browser.
      It returns all radio stations in specified order.

      - Parameters:
        - order: Tells the backend how to order the response. Available options are defined by the `ApiResponseOrder` parameter type. No default is given.
        - reverse: Tells the backend to reverse the requested order. Default is `false`.
        - offset: Offset from which the requested data set should start. Default is `0`.
        - limit: Number of items the API should respond, starting by `offset`. Default is `250`.
        - hideBroken: Tells the API whether to list or not list broken radio stations. `true` - list, `false` don't list. Default is `true`.
     */
    public func stations(
        order: ApiResponseOrder?,
        reverse: Bool? = false,
        offset: Int? = 0,
        limit: Int? = 250,
        hideBroken: Bool? = true,
        then completion: @escaping ([RadioBrowser.Station]?) -> Void = { _ in }
    ) {
        let request = StationRequest(api: self)
        request.stations(
            order: order,
            reverse: reverse,
            offset: offset,
            limit: limit,
            hideBroken: hideBroken,
            then: completion
        )
    }
    
    /**
      This call is part of the [List of radio stations](https://de1.api.radio-browser.info/#List_of_radio_stations) collection of Radio Browser.
      It returns all radio stations which name contains the given name string with a given limit.

      - Parameters:
        - name: Name of the Radio Station. The given string will be used as a wildcard string. It doesn't have to match exactly, it's rather a "contains" search.
        - order: Tells the backend how to order the response. Available options are defined by the `ApiResponseOrder` parameter type. No default is given.
        - reverse: Tells the backend to reverse the requested order. Default is `false`.
        - offset: Offset from which the requested data set should start. Default is `0`.
        - limit: Number of items the API should respond, starting by `offset`. Default is `250`.
        - hideBroken: Tells the API whether to list or not list broken radio stations. `true` - list, `false` don't list. Default is `true`.
     */
    public func stations(
        byName name: String,
        order: ApiResponseOrder?,
        reverse: Bool? = false,
        offset: Int? = 0,
        limit: Int? = 250,
        hideBroken: Bool? = true,
        then completion: @escaping ([RadioBrowser.Station]?) -> Void = { _ in }
    ) {
        let request = StationRequest(api: self)
        request.stations(
            byName: name,
            order: order,
            reverse: reverse,
            offset: offset,
            limit: limit,
            hideBroken: hideBroken,
            then: completion
        )
    }

    /**
      This call is part of the [List of radio stations](https://de1.api.radio-browser.info/#List_of_radio_stations) collection of Radio Browser.
      It returns all radio stations by a given two character country code with a given limit.

      - Parameters:
        - countryCode: Two letter country code. See: [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).
        - order: Tells the backend how to order the response. Available options are defined by the `ApiResponseOrder` parameter type. No default is given.
        - reverse: Tells the backend to reverse the requested order. Default is `false`.
        - offset: Offset from which the requested data set should start. Default is `0`.
        - limit: Number of items the API should respond, starting by `offset`. Default is `250`.
        - hideBroken: Tells the API whether to list or not list broken radio stations. `true` - list, `false` don't list. Default is `true`.
     */
    public func stations(
        byCountryCode countryCode: String,
        order: ApiResponseOrder?,
        reverse: Bool? = false,
        offset: Int? = 0,
        limit: Int? = 250,
        hideBroken: Bool? = true,
        then completion: @escaping ([RadioBrowser.Station]?) -> Void = { _ in }
    ) {
        let request = StationRequest(api: self)
        request.stations(
            byCountryCode: countryCode,
            order: order,
            reverse: reverse,
            offset: offset,
            limit: limit,
            hideBroken: hideBroken,
            then: completion
        )
    }

    /**
     Increases the click count of the given radio station by `1`.
     This should be called everytime when a user starts playing a stream to mark the stream more popular than others.
     Every call to this endpoint from the same IP address and for the same station only gets counted once per day.
     The call will return detailed information about the stream. The `ClickCount` model represents the call response.

     - Note: It is remmended to call this method everytime a stream starts playing.

     The JSON representation of `ClickCount` object should look like this:

     ```
     {
        "ok": true,
        "message": "retrieved station url",
        "stationuuid": "17142ca0-4faf-11e9-a4d7-52543be04c81",
        "name": "CITY23",
        "url": "http://live.radiomax.technology/city23"
     }
     ```

     - Parameters:
        - station: `Station` object whose click count should be increased.
        - completion: Optional completion callback, which returns a `ClickCount` object.
     */
    public func updateClickCount(for station: RadioBrowser.Station, completion: ((RadioBrowser.ClickCount?) -> Void)? = nil) {
        let request = ClickCountRequest(api: self)
        request.updateClickCount(for: station.stationUUID, completion: completion)
    }

    /**
     Returns configuration settings of the backend server. The response is represented by a `Config` object.

     - Parameters:
        - completion: Completion callback, which returns a `Config` object.
     */
    public func backendConfig(completion: @escaping (RadioBrowser.Config?) -> Void) {
        let request = ConfigRequest(api: self)
        request.backendConfig { config in
            completion(config)
        }
    }

}
