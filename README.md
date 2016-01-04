JJPianoControl
==============

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/JRJian/JJPianoControl/master/LICENSE)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;


此灵感来自最美应用APP，由于该APP的底部切换栏体验起来流畅性不是很好，所以自己仿着实现了一个。代码是用`Swift`写的，由于初学，代码也许不是很优雅，后期会继续完善！


Demo Project
==============

<img src="https://github.com/JRJian/JJPianoControl/blob/master/Demo/Snapshots/piano.gif" width="320"><br/>


Installation
==============

暂时没有加入Cocoapods
手动引入JJPianoControl入工程即可


Documentation
==============
#### 配置

```

public struct JJPianoControlConfig {
    
    // 间距
    static var margin : CGFloat = 2.0
    
    // 一页显示的最大钢琴键数
    static var numberOfKeysInPage: Int = 9
    
    // 钢琴键圆角度数
    static var keyCornerRadius: CGFloat = 5.0
    
    // 点击选中的最突出的钢琴键离顶部的距离
    static var pressKeyMaxTop: CGFloat = 8.0
    
    // 正常状态的钢琴键高度
    static var nomarlKeyHeight: CGFloat = 8.0
    
    // 取消触屏时延迟时间执行动画
    static var cancelTouchAnimationAfterDelay: NSTimeInterval = 0.5
    
    // 动画持续时间
    static var animationDuration: NSTimeInterval = 0.6
}

```

#### 代理

```

// MARK: - JJPianoBarView Delegate
   
func playPiano(from: NSIndexPath, to: NSIndexPath) {
    print("play from:\(from.row) to:\(to.row)")
}

```

Requirements
==============
由于采用Swift2.0，该项目最低支持 iOS 8.0。


About
==============
我希望调用 API 时，有着和调用系统自带 API 一样的体验，所以我并没有为 Category 方法添加前缀。我已经用工具扫描过这个项目中的 API，确保没有对系统 API 产生影响。我知道没有前缀的 Category 可能会带来麻烦，所以如果你只需要其中部分功能，请先查看上面那些拆分出来的子项目。

License
==============
JJPianoControl 使用 MIT 许可证，详情见 LICENSE 文件。

