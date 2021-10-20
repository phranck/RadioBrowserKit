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

    internal func setupCloudSync() {
        let store = NSUbiquitousKeyValueStore.default
        NotificationCenter.default.addObserver(self, selector: #selector(cloudSync(notification:)), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: store)
        log.debug("[CloudSync] sync started")
    }

    internal func stopCloudSync() {
        NotificationCenter.default.removeObserver(self)
        log.debug("[CloudSync] sync stopped")
    }

    @objc func cloudSync(notification: Notification) {
        log.debug("[CloudSync] notification received")
        guard let userInfo = notification.userInfo,
              let store = notification.object as? NSUbiquitousKeyValueStore,
              let changeReason = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? Int else {
            return
        }

        if changeReason == NSUbiquitousKeyValueStoreInitialSyncChange
            || changeReason == NSUbiquitousKeyValueStoreServerChange {

            guard let changedKeys = userInfo[NSUbiquitousKeyValueStoreChangedKeysKey] as? [String] else {
                return
            }
            let defaults = UserDefaults.standard
            for key in changedKeys {
                let value = store.object(forKey: key)
                defaults.set(value, forKey: key)
            }
        }
    }

    public func addToFavorites(station: Station) {
        DispatchQueue.main.async {
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: station, requiringSecureCoding: false)
            NSUbiquitousKeyValueStore.default.set(encodedData, forKey: station.stationUUID)
            NSUbiquitousKeyValueStore.default.synchronize()
            self.favorites.insert(station)
            log.debug("[\(station.name)] appended to favorites")
        }
    }

    public func removeFromFavorites(station: Station) {
        DispatchQueue.main.async {
            NSUbiquitousKeyValueStore.default.removeObject(forKey: station.stationUUID)
            NSUbiquitousKeyValueStore.default.synchronize()
            self.favorites.remove(station)
            log.debug("[\(station.name)] removed from favorites")
        }
    }

}
