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

    public func searchStations(withName name: String?, countryCode: String?, order: ApiResponseOrder?, orderRevers: Bool?, offset: Int?, limit: Int?) {
        let request = StationRequest(api: self)
        request.search(byName: name, countryCode: countryCode, order: order, reverse: orderRevers, limit: limit, offset: offset)
    }

    public func stations(byName name: String) {
        let request = StationRequest(api: self)
        request.search(byName: name, countryCode: nil, order: nil, reverse: nil, limit: nil, offset: nil)
    }

    public func stations(byCountryCode countryCode: String, limit: Int? = 10) {
        let request = StationRequest(api: self)
        request.search(byName: nil, countryCode: countryCode, order: nil, reverse: nil, limit: limit, offset: nil)
    }

    public func updateClickCount(for station: Station, completion: ((ClickCount?) -> Void)? = nil) {
        let request = ClickCountRequest(api: self)
        request.updateClickCount(for: station.stationUUID, completion: completion)
    }

    public func backendConfig(completion: @escaping (Config?) -> Void) {
        let request = ConfigRequest(api: self)
        request.backendConfig { config in
            if let config = config {
                log.debug(config)
            }
            completion(config)
        }
    }

}
