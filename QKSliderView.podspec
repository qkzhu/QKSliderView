Pod::Spec.new do |s|
  s.name             = 'QKSliderView'
  s.version          = '0.1.0'
  s.summary          = 'An UICollectionView that displays a small portion of previous and next page on the screen.'

  s.homepage         = 'https://github.com/qkzhu/QKSliderView'
  s.screenshots     = 'https://github.com/qkzhu/QKSliderView/blob/master/images/demo.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'qiankun' => 'lastencent@gmail.com' }
  s.source           = { :git => 'https://github.com/qkzhu/QKSliderView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'QKSliderView/*.{h,m}'
  s.public_header_files = 'QKSliderView/QKSliderView.h'
end
