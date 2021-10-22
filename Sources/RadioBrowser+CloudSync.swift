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
import Zephyr

extension RadioBrowser {

    enum CloudSyncKey: String {
        case favorites
    }

    internal func setupCloudSync() {
        Zephyr.addKeysToBeMonitored(keys: [
            RadioBrowser.CloudSyncKey.favorites.rawValue
        ])
        NotificationCenter.default.addObserver(self, selector: #selector(startCloudSync), name: Zephyr.keysDidChangeOnCloudNotification, object: nil)
        log.debug("sync started")
    }

    internal func stopCloudSync() {
        Zephyr.removeKeysFromBeingMonitored(keys: [
            RadioBrowser.CloudSyncKey.favorites.rawValue
        ])
        log.debug("sync stopped")
    }

    public func addToFavorites(station: Station) {
        DispatchQueue.main.async {
            self.favorites.append(station)
            UserDefaults.standard.setValue(self.favorites.data, forKey: RadioBrowser.CloudSyncKey.favorites.rawValue)
        }
    }

    public func removeFromFavorites(station: Station) {
        DispatchQueue.main.async {
            if let idx = self.favorites.firstIndex(of: station) {
                self.favorites.remove(at: idx)
                UserDefaults.standard.setValue(self.favorites.data, forKey: RadioBrowser.CloudSyncKey.favorites.rawValue)
            }
        }
    }

    @objc internal func startCloudSync() {
        if let favoritesData = UserDefaults.standard.value(forKey: RadioBrowser.CloudSyncKey.favorites.rawValue) as? Data,
           let cloudFavorites = Array<Station>(data: favoritesData) {
            DispatchQueue.main.async {
                self.favorites = cloudFavorites
            }
        }
    }

}
