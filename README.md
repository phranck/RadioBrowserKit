[![RadioBrowserKit CI](https://github.com/phranck/RadioBrowserKit/actions/workflows/RadioBrowserKit.yml/badge.svg)](https://github.com/phranck/RadioBrowserKit/actions/workflows/RadioBrowserKit.yml)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)
![Issues](https://img.shields.io/github/issues/phranck/RadioBrowserKit)
![Tag](https://img.shields.io/github/tag/phranck/RadioBrowserKit.svg?color=blue&label=Tag)

# RadioBrowserKit - The Swift SDK for Radio Browser

Radio Streams from all over the world. Free and Open.  
RadioBrowserKit is a Swift package which lets you use the free and Open Source [Radio Browser API](https://de1.api.radio-browser.info).

## Installation

`RadioBrowserKit.git` works with Swift 5.3 and above for iOS and macOS.

### Swift Package Manager

```Swift
let package = Package(
  name: "MyPackage",
  dependencies: [
    .package(url: "https://github.com/phranck/RadioBrowserKit.git", from: "0.1.0"),
  ]
)
```

### Carthage

Put this in your `Cartfile`:

```
github "phranck/RadioBrowserKit" ~> 0.1
```

## How to use it?

The first thing you have to do is create an instance of the  `RadioBrowser` class. This can be done at the beginning of your app launch. For SwiftUI you can provide it as an environment object via view modifier.

```Swift
@main
struct MyApp: App {
    @StateObject var radioBrowserApi = RadioBrowser()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(radioBrowserApi)
        }
    }
}
```

Actually `RadioBrowser` publishes four observed properties which you can use in your SwiftUI view automatic refreshing (a `RadioBrowserDelegate` to use it in a UIKit app will follow later):

```Swift
@Published public internal(set) var stations: [Station] = []
@Published public internal(set) var favorites: [Station] = []
@Published public internal(set) var isLoading: Bool = false
```

## Developer Notes

`RadioBrowserKit` uses [GitFlow](http://githubflow.github.io). There are two branches, `main` and `develop`. The `develop` branch is the default branch. To provide (*changes*|*fixes*|*additions*) you just have to fork this repository and create your working branch with `develop` as base. If you’re done, just open a pull request.

## Contact

* 📧 [Write me an email](mailto:hello@woodbytes.me)
* 🦣 [Ping me on Mastodon](https://chaos.social/@phranck)
* 📋 [Read my blog](https://woodbytes.me)

## License
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">RadioBrowserKit</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://woordbytes.me" property="cc:attributionName" rel="cc:attributionURL">Frank Gregor</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.