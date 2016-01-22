//
//  JJPianoBarView.swift
//  JJPianoControl
//
//  Created by chenjiantao on 15/12/31.
//  Copyright © 2015年 chenjiantao. All rights reserved.
//

import UIKit

// MARK : - JJPianoKeysConfig
// 样式配置 (含默认配置)

public struct JJPianoControlConfig {
    
    // 钢琴键之间的间距
    static var margin               : CGFloat           = 2.0
    
    // 钢琴键内间距
    static var keyPadding           : CGFloat           = 2.0
    
    // 一页显示的最大钢琴键数
    static var numberOfKeysInPage   : Int               = 9
    
    // 钢琴键圆角度数
    static var keyCornerRadius      : CGFloat           = 7.5
    
    // 点击选中的最突出的钢琴键离顶部的距离
    static var pressKeyMaxTop       : CGFloat           = 8.0
    
    // 正常状态的钢琴键高度
    static var nomarlKeyHeight      : CGFloat           = 8.0
    
    // 动画持续时间
    static var animationDuration    : NSTimeInterval    = 0.6
    
    // 取消触屏时延迟时间执行动画
    static var cancelTouchAnimationAfterDelay: NSTimeInterval = 0.5
}

// MARK : - JJPianoBarCell

class JJPianoBarCell : UICollectionViewCell {
    
    private var iconView: UIImageView!
    private var textLabel: UILabel!
    
    var text: String? {
        willSet {
            self.textLabel.text = newValue
        }
    }
    
    var iconUrl : String? {
        willSet {
            self.iconUrl = newValue
        }
        
        didSet {
            self.iconView.image = UIImage(named: iconUrl!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.iconView   = UIImageView()
        self.textLabel  = UILabel()
        self.addSubview(self.iconView)
        self.addSubview(self.textLabel)
        self.backgroundColor = UIColor.whiteColor()
        
        // 设置钢琴键 左上|右上 圆角
        var maskPath: UIBezierPath
        maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSize(width: JJPianoControlConfig.keyCornerRadius, height: JJPianoControlConfig.keyCornerRadius))
        
        var maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame             = self.bounds
        maskLayer.path              = maskPath.CGPath
        self.layer.mask             = maskLayer
        self.layer.masksToBounds    = true
        
        // 设置图片圆角
        var iconFrame = CGRectMake(0, 0, frame.size.width - JJPianoControlConfig.keyPadding * 2.0, frame.size.width - JJPianoControlConfig.keyPadding * 2.0)
        maskPath    = UIBezierPath(roundedRect: iconFrame, byRoundingCorners: [.AllCorners], cornerRadii: CGSize(width: JJPianoControlConfig.keyCornerRadius, height: JJPianoControlConfig.keyCornerRadius))
        maskLayer   = CAShapeLayer()
        maskLayer.frame     = iconFrame
        maskLayer.path      = maskPath.CGPath
        iconFrame.origin    = CGPointMake(JJPianoControlConfig.keyPadding, JJPianoControlConfig.keyPadding)
        self.iconView.frame = iconFrame
        self.iconView.layer.masksToBounds   = true
        self.iconView.layer.mask            = maskLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK : - JJPianoBarFlowLayout

class JJPianoBarFlowLayout : UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.scrollDirection    = UICollectionViewScrollDirection.Horizontal
        self.sectionInset       = UIEdgeInsetsMake(0, JJPianoControlConfig.margin, 0, JJPianoControlConfig.margin)
        self.minimumLineSpacing = JJPianoControlConfig.margin
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewFlowLayout methods
    
    override func prepareLayout() {
        super.prepareLayout()
        self.itemSize = CGSizeMake((UIScreen.mainScreen().bounds.width - CGFloat((JJPianoControlConfig.numberOfKeysInPage + 1)) * JJPianoControlConfig.margin) / CGFloat(JJPianoControlConfig.numberOfKeysInPage), self.collectionView!.bounds.height * 1.25)
        
        var cache: Array<UICollectionViewLayoutAttributes> = Array()
        let numberOfItems = self.collectionView!.numberOfItemsInSection(0)
        
        var frame   = CGRectZero
        var left    : CGFloat = 0.0
        
        for index in 0..<numberOfItems {
            let indexPath: NSIndexPath = NSIndexPath(forItem: index, inSection: 0)
            let attributes: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attributes.zIndex = index
            
            left                = (self.itemSize.width + JJPianoControlConfig.margin) * CGFloat(index) + JJPianoControlConfig.margin
            frame.size          = self.itemSize
            frame.origin        = CGPointMake(left, self.collectionView!.bounds.size.height - JJPianoControlConfig.nomarlKeyHeight)
            attributes.frame    = frame
            cache.append(attributes)
        }
        
        self.cachedLayoutAttributes = cache
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: Array<UICollectionViewLayoutAttributes> = Array()
        for attribute in self.cachedLayoutAttributes {
            if CGRectIntersectsRect(attribute.frame, rect) {
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cachedLayoutAttributes[indexPath.item]
    }
    
    override func collectionViewContentSize() -> CGSize {
        let contentWidth  = (self.itemSize.width + JJPianoControlConfig.margin) * CGFloat(self.collectionView!.numberOfItemsInSection(0)) + JJPianoControlConfig.margin
        let contentHeight = self.collectionView!.bounds.size.height
        return CGSizeMake(contentWidth, contentHeight)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    private var cachedLayoutAttributes: Array<UICollectionViewLayoutAttributes>!
}

// MARK : - Protocol

@objc protocol JJPianoBarViewDelegate {
    optional func playPiano(from: NSIndexPath, to: NSIndexPath)
}

// MARK : - JJPianoBarView

class JJPianoBarView : UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.clipsToBounds      = false
        self.scrollEnabled      = false
        self.backgroundColor    = UIColor.clearColor()
        self.showsVerticalScrollIndicator   = false
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.loadVisibleCells()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.setupLayout(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let tIndexPath: NSIndexPath? = self.indexPathForCell(self.curCell!)
        let fIndexPath: NSIndexPath? = self.indexPathForCell(self.lastCell ?? self.curCell!)
        self.pianoDelegate?.playPiano?(fIndexPath!, to: tIndexPath!)
        
        self.calmAnimate()
        
        if self.curCell == nil || self.lastCell == self.curCell {
            return
        }
        self.lastCell = self.curCell
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.calmAnimate()
    }
    
    func scrollTo(scrollTo: Int) {
        
        let row = min(scrollTo, self.numberOfItemsInSection(0) - 1)
        let indexPath: NSIndexPath = NSIndexPath(forRow: row, inSection: 0)
        self.lastCell = self.curCell

        /*
        From the UICollectionView docs (emphasis my own)
        
        Return Value
        The cell object at the corresponding index path or nil if the cell is not visible or indexPath is out of range.
        */
        
        self.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        
        var offset = 0
        if let _ = self.curCell {
            let curIndexPath: NSIndexPath? = self.indexPathForCell(self.curCell!)
            offset = abs(curIndexPath!.row - scrollTo)
        }
        let after     = offset < 10 ? 0.1 : 0.25 + (Double(offset) * 0.001)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(after * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.loadVisibleCells()
            let toCell: UICollectionViewCell? = self.cellForItemAtIndexPath(indexPath)
            if let _ = toCell {
                self.curCell = toCell!
                self.calmAnimate()
            }
        }
    }
    
    private func loadVisibleCells() {
        
        // 获取显示的cell
        var orderCells : Array<UICollectionViewCell> = Array()
        for cell in self.visibleCells() {
            orderCells.append(cell)
        }
        
        // 排序按cell的x从小到大
        orderCells.sortInPlace ( { s1, s2 in s1.left < s2.left } )
        
        self.orderCells = orderCells
    }
    
    /**
     更新 cell 布局
     
     - parameter touches: 触碰集合
     */
    private func setupLayout(touches : Set<UITouch>) {
        
        // 获取点击的位置
        let touch : UITouch = (touches as NSSet).anyObject() as! UITouch
        let clickPoint : CGPoint = touch.locationInView(self)
        
        // 判断点在哪个cell
        for index in 0..<self.orderCells.count {
            let cell = self.orderCells[index]
            if CGRectContainsPoint(CGRectMake(cell.left, 0, cell.width, cell.height), clickPoint) {
                self.waveAnimate(cell, index: index)
                break
            }
        }
    }
    
    /**
     停止触屏后的动画
     */
    private func calmAnimate() {
        UIView.animateWithDuration(JJPianoControlConfig.animationDuration, delay: JJPianoControlConfig.cancelTouchAnimationAfterDelay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            for i in 0..<self.orderCells.count {
                let cell = self.orderCells[i]
                cell.top = cell == self.curCell ? JJPianoControlConfig.pressKeyMaxTop : self.bounds.size.height - JJPianoControlConfig.nomarlKeyHeight
            }
            }, completion: nil)
    }
    
    /**
     手指持续滑动，钢琴键动画
     
     - parameter centerCell: 触碰到的钢琴键
     - parameter index:      索引
     */
    private func waveAnimate(centerCell: UICollectionViewCell, index: Int) {
        
        if self.curCell == centerCell { return }
        self.curCell = centerCell
        
        // Damping 越小，弹簧振动效果越明显
        // Velocity 越大，弹簧振动效果越明显
        UIView.animateWithDuration(JJPianoControlConfig.animationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            for i in 0..<self.orderCells.count {
                let cell = self.orderCells[i]
                let top = CGFloat(abs(i - index) * 10)
                cell.top = min(top, self.bounds.size.height - JJPianoControlConfig.nomarlKeyHeight)
            }
            }, completion: nil)
    }
    
    private var orderCells  : Array<UICollectionViewCell>!
    
    // 保存当前index
    private var curCell     : UICollectionViewCell?
    
    // 上一个index
    private var lastCell    : UICollectionViewCell?
    
    // 代理
    var pianoDelegate       : JJPianoBarViewDelegate?
}
