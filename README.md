A framework for testing the testability of Swift code.

## Requirements

- iOS 14.0+ 
- Xcode 10.0+
- Swift 4.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build CodeTestabilityInspector 1.0.0+

To integrate CodeTestabilityInspector into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'gh repo clone stronv/CodeTestabilityInspector'
platform :ios, '14.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'CodeTestabilityInspector'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

### Quick Start

```swift
import CodeTestabilityInspector

class MyViewController: UIViewController {

    private let filePath = "<The full path to your file>"
    private let analyzer = CodeAnalyzer()

    override func viewDidLoad() {
        super.viewDidLoad()
        analyzer.calculateCyclomaticComplexity(atPath: filePath)
        analyzer.calculateTheMaintainabilityIndex(atPath: filePath)
        analyzer.calcualteCohesionAndCoupling(atPath: filePath)
        analyzer.analyzeCodeTestability(atPath: filePath)
    }
}
```
