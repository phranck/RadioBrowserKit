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
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,1
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import SwiftUI
import SwiftyBeaver
import Zephyr

let log = SwiftyBeaver.self

public class RadioBrowserAPI: ObservableObject {
    internal static let version = "0.1.3"
    internal static let build = 1
    internal static let apiServer: RadioBrowserServer

    // MARK: - Public API

    public static var httpUserAgent: String = "\(RadioBrowserAPI.self)/\(RadioBrowserAPI.version)"
    public static var apiResponseFormat: ApiResponseFormat = .json

    @Published public internal(set) var stations: [RadioBrowser.Station] = []
    @Published public internal(set) var isLoading: Bool = false

    static var delegate: RadioBrowserDelegate?

    public init(
        delegate: RadioBrowserDelegate? = nil, 
        servers: @escaping () -> [String] = { String.defaultServers },
        prefetches: Bool = true
    ) {
        apiServer = RadioBrowserServer(servers: servers)
        RadioBrowserAPI.delegate = delegate

        /// Prefetch all stations by current region code
        if prefetches {
            stations(byCountryCode: Locale.current.regionCode!, order: .clickCount, reverse: true, limit: 50)
        }
    }
}

public protocol RadioBrowserDelegate {
    func radioBrowser(willStartRequest: URLRequest)
    func radioBrowser(endRequest: URLRequest, withError: Error)
    func radioBrowser(_ radioBrowser: RadioBrowserAPI, receivedStations: [RadioBrowser.Station])
    func radioBrowser(_ radioBrowser: RadioBrowserAPI, receivedConfig: RadioBrowser.Config)
    func radioBrowser(_ radioBrowser: RadioBrowserAPI, didUpdateClickCount: RadioBrowser.ClickCount)
}
