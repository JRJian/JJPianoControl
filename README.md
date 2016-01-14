JJPianoControl
==============

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/JRJian/JJPianoControl/master/LICENSE)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;


此灵感来自最美应用APP。


Demo Project
==============

<img src="https://github.com/JRJian/JJPianoControl/blob/master/Demo/Snapshots/piano.gif" width="320"><br/>


Installation
==============

暂时没有加入Cocoapods
手动引入JJPianoControll文件夹到工程即可使用

Documentation
==============
#### 配置

```

public struct JJPianoControlConfig {
    
    // 间距
    static var margin : CGFloat = 2.0
    
    // 图片内间距
    static var keyPadding : CGFloat = 2.0
    
    // 一页显示的最大钢琴键数
    static var numberOfKeysInPage: Int = 9
    
    // 钢琴键圆角度数
    static var keyCornerRadius: CGFloat = 7.5
    
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

#### 初始化

```

let frame = CGRectMake(0, UIScreen.mainScreen().bounds.height - 54, UIScreen.mainScreen().bounds.width, 54)
let layout: JJPianoBarFlowLayout = JJPianoBarFlowLayout()
let bar: JJPianoBarView = JJPianoBarView(frame: frame, collectionViewLayout: layout)
bar.registerClass(JJPianoBarCell.self, forCellWithReuseIdentifier: "Cell")
bar.dataSource = self
bar.delegate   = self
bar.pianoDelegate = self
self.view.addSubview(bar)
bar.scrollTo(0)

```

#### 代理

```

// MARK: - JJPianoBarView Delegate
   
func playPiano(from: NSIndexPath, to: NSIndexPath) {
    print("play from:\(from.row) to:\(to.row)")
}

// mark: - UIColletionView Delegate

func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell : JJPianoBarCell! = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! JJPianoBarCell
    cell.iconUrl = self.avatars[indexPath.row % avatars.count]
    return cell
}

```

Requirements
==============
由于采用Swift2.0，该项目最低支持 iOS 8.0。


About
==============
该控制器继承自:UICollectionView

代码还有不足点，比如如何监听scrollToItemAtIndexPath结束后的回调，暂时没找到合适的解决方案。

License
==============
JJPianoControl 使用 MIT 许可证，详情见 LICENSE 文件。

