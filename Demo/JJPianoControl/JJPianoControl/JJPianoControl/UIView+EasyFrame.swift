//
//  UIView+EasyFrame.swift
//  JJPianoControl
//
//  Created by chenjiantao on 15/12/31.
//  Copyright © 2015年 chenjiantao. All rights reserved.
//

import UIKit
import Foundation

public extension UIView {
    
    public var left : CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    public var top : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    public var width : CGFloat {
        get {
            return self.frame.size.width
        }
        
        set {
            self.frame.size.width = newValue
        }
    }
    
    public var height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            self.frame.size.height = newValue
        }
    }
    
    public var size : CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
    
    public var origin : CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }
    
}