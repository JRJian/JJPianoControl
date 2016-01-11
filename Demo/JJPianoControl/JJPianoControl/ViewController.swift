//
//  ViewController.swift
//  JJPianoControl
//
//  Created by chenjiantao on 15/12/31.
//  Copyright © 2015年 chenjiantao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, JJPianoBarViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var paino: JJPianoBarView?
    var nextIndex: Int = 0
    var avatars: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init
        self.avatars = ["avatar-1", "avatar-2", "avatar-3", "avatar-4", "avatar-5", "avatar-6", "avatar-7"];
        
        // config
        JJPianoControlConfig.margin = 2.0
        
        // setup UI
        let frame = CGRectMake(0, UIScreen.mainScreen().bounds.height - 54, UIScreen.mainScreen().bounds.width, 54)
        let layout: JJPianoBarFlowLayout = JJPianoBarFlowLayout()
        let bar: JJPianoBarView = JJPianoBarView(frame: frame, collectionViewLayout: layout)
        bar.registerClass(JJPianoBarCell.self, forCellWithReuseIdentifier: "Cell")
        bar.dataSource = self
        bar.delegate   = self
        bar.pianoDelegate = self
        self.view.addSubview(bar)
        bar.autoresizingMask = [.FlexibleTopMargin]
        bar.scrollTo(0)
        self.paino = bar
        
        let rect: CGRect = CGRectMake(100, 100, 100, 60)
        let btn: UIButton! = UIButton(frame: rect)
        btn.center = self.view.center
        btn.setTitle("next", forState: UIControlState.Normal)
        btn.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }
    
    func buttonClicked(_: UIButton) {
        nextIndex += 1
        if nextIndex >= self.paino?.numberOfItemsInSection(0) {
            nextIndex = 0
        }
        self.paino?.scrollTo(nextIndex)
    }
    
    // MARK: - JJPianoBarView Delegate
    
    func playPiano(from: NSIndexPath, to: NSIndexPath) {
        print("play from:\(from.row) to:\(to.row)")
    }
    
    // MARK: - UICollection Delegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : JJPianoBarCell! = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! JJPianoBarCell
        cell.text = String(indexPath.row)
        cell.iconUrl = self.avatars[indexPath.row % avatars.count]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
}

