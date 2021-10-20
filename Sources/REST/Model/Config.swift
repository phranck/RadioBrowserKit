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

public class Config: Codable {
    public var checkEnabled: Bool
    public var prometheusExporterEnabled: Bool
    public var pullServers: [String]
    public var tcpTimeoutSeconds: Int
    public var brokenStationsNeverWorkingTimeoutSeconds: Int
    public var brokenStationsTimeoutSeconds: Int
    public var checksTimeoutSeconds: Int
    public var clickSalidTimeoutSeconds: Int
    public var clicksTimeoutSeconds: Int
    public var mirrorPullIntervalSeconds: Int
    public var updateCachesIntervalSeconds: Int
    public var serverName: String
    public var serverLocation: String
    public var serverCountryCode: String
    public var checkRetries: Int
    public var checkBatchsize: Int
    public var checkPauseSeconds: Int
    public var apiThreads: Int
    public var cacheType: String
    public var cacheTtl: Int

    private enum CodingKeys: String, CodingKey {
        case checkEnabled                             = "check_enabled"
        case prometheusExporterEnabled                = "prometheus_exporter_enabled"
        case pullServers                              = "pull_servers"
        case tcpTimeoutSeconds                        = "tcp_timeout_seconds"
        case brokenStationsNeverWorkingTimeoutSeconds = "broken_stations_never_working_timeout_seconds"
        case brokenStationsTimeoutSeconds             = "broken_stations_timeout_seconds"
        case checksTimeoutSeconds                     = "checks_timeout_seconds"
        case clickSalidTimeoutSeconds                 = "click_valid_timeout_seconds"
        case clicksTimeoutSeconds                     = "clicks_timeout_seconds"
        case mirrorPullIntervalSeconds                = "mirror_pull_interval_seconds"
        case updateCachesIntervalSeconds              = "update_caches_interval_seconds"
        case serverName                               = "server_name"
        case serverLocation                           = "server_location"
        case serverCountryCode                        = "server_country_code"
        case checkRetries                             = "check_retries"
        case checkBatchsize                           = "check_batchsize"
        case checkPauseSeconds                        = "check_pause_seconds"
        case apiThreads                               = "api_threads"
        case cacheType                                = "cache_type"
        case cacheTtl                                 = "cache_ttl"
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        checkEnabled                             = try container.decode(Bool.self, forKey: .checkEnabled)
        prometheusExporterEnabled                = try container.decode(Bool.self, forKey: .prometheusExporterEnabled)
        pullServers                              = try container.decode([String].self, forKey: .pullServers)
        tcpTimeoutSeconds                        = try container.decode(Int.self, forKey: .tcpTimeoutSeconds)
        brokenStationsNeverWorkingTimeoutSeconds = try container.decode(Int.self, forKey: .brokenStationsNeverWorkingTimeoutSeconds)
        brokenStationsTimeoutSeconds             = try container.decode(Int.self, forKey: .brokenStationsTimeoutSeconds)
        checksTimeoutSeconds                     = try container.decode(Int.self, forKey: .checksTimeoutSeconds)
        clickSalidTimeoutSeconds                 = try container.decode(Int.self, forKey: .clickSalidTimeoutSeconds)
        clicksTimeoutSeconds                     = try container.decode(Int.self, forKey: .clicksTimeoutSeconds)
        mirrorPullIntervalSeconds                = try container.decode(Int.self, forKey: .mirrorPullIntervalSeconds)
        updateCachesIntervalSeconds              = try container.decode(Int.self, forKey: .updateCachesIntervalSeconds)
        serverName                               = try container.decode(String.self, forKey: .serverName)
        serverLocation                           = try container.decode(String.self, forKey: .serverLocation)
        serverCountryCode                        = try container.decode(String.self, forKey: .serverCountryCode)
        checkRetries                             = try container.decode(Int.self, forKey: .checkRetries)
        checkBatchsize                           = try container.decode(Int.self, forKey: .checkBatchsize)
        checkPauseSeconds                        = try container.decode(Int.self, forKey: .checkPauseSeconds)
        apiThreads                               = try container.decode(Int.self, forKey: .apiThreads)
        cacheType                                = try container.decode(String.self, forKey: .cacheType)
        cacheTtl                                 = try container.decode(Int.self, forKey: .cacheTtl)
    }
}
