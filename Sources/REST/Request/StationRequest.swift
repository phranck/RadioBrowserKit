import Foundation

internal class StationRequest: ApiFetch {
    internal func search(
        name: String?,
        nameExact: Bool?,
        country: String?,
        countryExact: Bool?,
        countryCode: String?,
        state: String?,
        stateExact: Bool?,
        language: String?,
        languageExact: Bool?,
        tag: String?,
        tagExact: Bool?,
        tagList: String?,
        codec: String?,
        bitrateMin: Int?,
        bitrateMax: Int?,
        hasGeoInfo: Bool?,
        hasExtendedInfo: Bool?,
        order: ApiResponseOrder?,
        reverse: Bool?,
        offset: Int?,
        limit: Int?,
        hideBroken: Bool?,
        then completion: @escaping (StationResource.ModelType?) -> Void = { _ in }
    ) {
        var resource = StationResource(endpoint: .stationsSearch)
        resource.name = name
        resource.nameExact = nameExact
        resource.country = country
        resource.countryExact = countryExact
        resource.countryCode = countryCode
        resource.state = state
        resource.stateExact = stateExact
        resource.language = state
        resource.languageExact = languageExact
        resource.tag = state
        resource.tagExact = tagExact
        resource.tagList = tagList
        resource.codec = codec
        resource.bitrateMin = bitrateMin
        resource.bitrateMax = bitrateMax
        resource.hasGeoInfo = hasGeoInfo
        resource.hasExtendedInfo = hasExtendedInfo
        resource.order = order
        resource.reverse = reverse
        resource.offset = offset
        resource.limit = limit
        resource.hideBroken = hideBroken

        stations(with: resource, then: completion)
    }

    internal func stations(
        order: ApiResponseOrder?,
        reverse: Bool?,
        offset: Int?,
        limit: Int?,
        hideBroken: Bool?,
        then completion: @escaping (StationResource.ModelType?) -> Void = { _ in }
    ) {
        var resource = StationResource(endpoint: .stations)
        resource.order = order
        resource.reverse = reverse
        resource.offset = offset
        resource.limit = limit
        resource.hideBroken = hideBroken

        stations(with: resource, then: completion)
    }
    
    internal func stations(
        byName name: String,
        order: ApiResponseOrder?,
        reverse: Bool?,
        offset: Int?,
        limit: Int?,
        hideBroken: Bool?,
        then completion: @escaping (StationResource.ModelType?) -> Void = { _ in }
    ) {
        var resource = StationResource(endpoint: .stationsByName)
        resource.path = name
        resource.order = order
        resource.reverse = reverse
        resource.offset = offset
        resource.limit = limit
        resource.hideBroken = hideBroken

        stations(with: resource, then: completion)
    }

    internal func stations(
        byCountryCode code: String,
        order: ApiResponseOrder?,
        reverse: Bool?,
        offset: Int?,
        limit: Int?,
        hideBroken: Bool?,
        then completion: @escaping (StationResource.ModelType?) -> Void = { _ in }
    ) {
        var resource = StationResource(endpoint: .stationsByCountryCode)
        resource.path = code
        resource.order = order
        resource.reverse = reverse
        resource.offset = offset
        resource.limit = limit
        resource.hideBroken = hideBroken

        stations(with: resource, then: completion)
    }

    private func stations(
        with resource: StationResource,
        then completion: @escaping (StationResource.ModelType?) -> Void = { _ in }
    ) {
        api.isLoading = true
        performRequest(with: resource) { result in
            DispatchQueue.main.async {
                if let stations = result {
                    self.api.stations = stations
                    RadioBrowserAPI.delegate?.radioBrowser(self.api, receivedStations: stations)
                }
                completion(result)
                self.api.isLoading = false
            }
        }
    }
}
