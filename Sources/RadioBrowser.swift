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

import SwiftUI
import SwiftyBeaver

let log = SwiftyBeaver.self

public class RadioBrowser: ObservableObject {
    internal static let apiServer = RadioBrowserServer()

    @Published public internal(set) var stations: Set<Station> = []
    @Published public internal(set) var favorites: Set<Station> = []
    @Published public internal(set) var error: RadioBrowserError = .none
    @Published public internal(set) var isLoading: Bool = false

    public init() {
        setupCloudSync()

        stations(by: nil, countryCode: Locale.current.regionCode, order: .votes, orderRevers: true, offset: nil, limit: 25)
    }

    deinit {
        stopCloudSync()
     }
}

//@propertyWrapper
//struct StationFavorite<Value: Station> {
//    let key: String
//
//    init(_ key: String) {
//        self.key = key
//    }
//
//    var wrappedValue: Value {
//        get {
//            if let data = UserDefaults.standard.object(forKey: key) as? Data,
//               let user = try? JSONDecoder().decode(Value.self, from: data) {
//                return user
//            }
//            return nil
//        }
//        set {
//            if let encoded = try? JSONEncoder().encode(newValue) {
//                UserDefaults.standard.set(encoded, forKey: key)
//            }
//        }
//    }
//}
