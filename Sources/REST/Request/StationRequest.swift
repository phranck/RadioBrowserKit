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

internal class StationRequest: ApiFetch {

    internal func search(byName name: String?, countryCode: String?, order: ApiResponseOrder?, reverse: Bool?, limit: Int?, offset: Int?) {
        var resource = StationResource(endpoint: .stationsSearch)
        resource.searchterm = name
        resource.countryCode = countryCode
        resource.order = order
        resource.reverse = reverse
        resource.limit = limit
        resource.offset = offset
        resource.hideBroken = true

        stations(with: resource)
    }

    internal func stations(byName name: String) {
        var resource = StationResource(endpoint: .stationsByName)
        resource.path = name
        resource.hideBroken = true

        stations(with: resource)
    }

    private func stations(with resource: StationResource) {

        api.isLoading = true
        performRequest(with: resource) { result in
            DispatchQueue.main.async {
                if let result = result {
                    self.api.stations = []
                    for station in result {
                        self.api.stations.append(station)
                    }
                }
                self.api.isLoading = false
            }
        }
    }

}
