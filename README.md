# QKSliderView

[![CI Status](https://img.shields.io/travis/qkzhu/QKSliderView.svg?style=flat)](https://travis-ci.org/qkzhu/QKSliderView)
[![Version](https://img.shields.io/cocoapods/v/QKSliderView.svg?style=flat)](https://cocoapods.org/pods/QKSliderView)
[![License](https://img.shields.io/cocoapods/l/QKSliderView.svg?style=flat)](https://cocoapods.org/pods/QKSliderView)
[![Platform](https://img.shields.io/cocoapods/p/QKSliderView.svg?style=flat)](https://cocoapods.org/pods/QKSliderView)
[![中文 README](https://img.shields.io/badge/%E4%B8%AD%E6%96%87-README-blue.svg?style=flat)](https://github.com/qkzhu/QKSliderViewTemp/blob/master/README.zh-cn.md)

## Preview
<img src="https://github.com/qkzhu/QKSliderViewTemp/blob/master/images/demo.gif" width="222" height="480"/>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

QKSliderView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QKSliderView'
```

## How to use (or refer to Example)
### Using storyboard
1. Drag a `UICollectionView` to storyboard.
2. Open `Inspector panel`, change class to `QKSliderView`. 
<img src="https://github.com/qkzhu/QKSliderViewTemp/blob/master/images/class.png"/>
3. Open `Inspector panel`, update neccessary properties such as total number of rows, columns etc. 
<img src="https://github.com/qkzhu/QKSliderViewTemp/blob/master/images/config.png"/>

### Programmatically
```Swift
let sliderView = QKSliderView(rows: 2, columns: 2, cellGapH: 8, cellGapV: 4, cellRemainWidth: 8)
sliderView.dataSource = self //UICollectionViewDataSource
self.view.addSubview(sliderView)
// then add constraints or adjust frame
```

### Terms explanation
<img src="https://github.com/qkzhu/QKSliderViewTemp/blob/master/images/explain.png" width="310" height="672"/>

## Author

[qiankun](lastencent@gmail.com)

## License

QKSliderView is available under the MIT license. See the LICENSE file for more info.
