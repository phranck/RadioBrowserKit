[![RadioBrowserKit CI](https://github.com/phranck/RadioBrowserKit/actions/workflows/RadioBrowserKit.yml/badge.svg)](https://github.com/phranck/RadioBrowserKit/actions/workflows/RadioBrowserKit.yml)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)
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

## Developer Notes

`RadioBrowserKit` uses [GitFlow](http://githubflow.github.io). There are two branches, `main` and `develop`. The `develop` branch is the default branch. To provide (*changes*|*fixes*|*additions*) you just have to fork this repository and create your working branch with `develop` as base. If you’re done, just open a pull request.

## Contact

* :envelope: [Write me an email](mailto:hello@woodbytes.me)
* :bird: [Ping me on Twitter](https://twitter.com/_Woodbytes_)
* :memo: [Read my blog](https://woodbytes.me)

## License
This software is published under the [MIT License](http://cocoanaut.mit-license.org).
