import Foundation

public extension Locale {
    struct LocaleRegion {
        let code: String
        let name: String
    }

    static var regions: [LocaleRegion] = {
        Locale.isoRegionCodes.compactMap { code in
            guard let region = Locale.current.localizedString(forRegionCode: code) else { return nil }
            return LocaleRegion(code: code, name: region)
        }
    }()
}
