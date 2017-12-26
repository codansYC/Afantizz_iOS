//
//  SlideView.swift
//  LikingManager
//
//  Created by yuanchao on 16/9/29.
//  Copyright © 2016年 LikingFit. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SlideView: BaseView {
    
    let SCREENWIDTH = UIScreen.main.bounds.width
    let SCREENHEIGHT = UIScreen.main.bounds.height
    
    var screenPan: UIScreenEdgePanGestureRecognizer!
    var bgV: UIView?
    var direction = Direction.right
    
    var isShow = false
    
    var minX: CGFloat {
        return direction == .left ? -bounds.width : SCREENWIDTH - bounds.width }
    var maxX: CGFloat {
        return direction == .left ? 0 : SCREENWIDTH
    }
    var midX: CGFloat {
        return (maxX + minX) / 2
    }
    var currentX: CGFloat { return frame.origin.x }
    var bgVColor: UIColor {
        let alphaComponent = 0.5 * (maxX - currentX) / (maxX - minX)
        return UIColor.black.withAlphaComponent(alphaComponent)
    }
    
    init(direction: Direction) {
        let x: CGFloat = direction == .left ? -220 : SCREENWIDTH
        super.init(frame: CGRect(x: x, y: 0, width: 220, height: SCREENHEIGHT-64))
        
        self.direction = direction
        
        commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        
    }
    
    init() {
        super.init(frame: CGRect(x: SCREENWIDTH, y: 0, width: 220.layout, height: SCREENHEIGHT-64))
        
        commonInit()
    }
    
    func commonInit() {
 
        backgroundColor = UIColor.white
        
        let pan = UIPanGestureRecognizer()
        pan.rx.event.bind { [unowned self] (pan) in
            self.handlePan(pan)
            }.disposed(by: disposeBag)
        self.addGestureRecognizer(pan)
        
        bgV = UIView()
        bgV?.backgroundColor = bgVColor
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.bind { [unowned self] (tap) in
            self.dismiss()
            }.disposed(by: disposeBag)
        bgV?.addGestureRecognizer(tap)
        
        let bgVPan = UIPanGestureRecognizer()
        bgVPan.rx.event.bind { [unowned self](pan) in
            self.handlePan(pan)
            }.disposed(by: disposeBag)
        bgV?.addGestureRecognizer(bgVPan)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let superview = superview else { return }
        
        if screenPan == nil {
            screenPan = UIScreenEdgePanGestureRecognizer()
            screenPan.edges = direction == .left ? .left : .right
            screenPan.rx.event.bind { [unowned self] (pan) in
                self.handlePan(pan)
                }.disposed(by: disposeBag)
            superview.addGestureRecognizer(screenPan)
        }
        bgV?.frame = superview.bounds

    }
    
    func handlePan(_ pan:UIPanGestureRecognizer) {
        
        bgVShowing()
        
        let pt = pan.translation(in: superview)
        let tempX = currentX + pt.x
        if tempX > maxX {
            frame.origin.x = maxX
        } else if tempX < minX {
            frame.origin.x = minX
        } else {
            frame.origin.x = tempX
        }
        
        switch pan.state {
        case .cancelled, .ended:
            if pan.velocity(in: superview).x < -1500 {
                direction == .left ? dismiss() : show()
            } else if pan.velocity(in: superview).x > 1500 {
                direction == .left ? show() : dismiss()
            } else {
                if direction == .left {
                    currentX > midX ? show() : dismiss()
                } else {
                    currentX > midX ? dismiss() : show()
                }
                
            }
            
        default:
            break
        }
        
        pan.setTranslation(CGPoint.zero, in: superview)
        
    }
    
    func show() {
        
        isShow = true
        UIView.animate(withDuration: 0.3, animations: {
            if self.direction == .left {
                self.frame.origin.x = self.maxX
            } else {
                self.frame.origin.x = self.minX
            }
            self.bgV?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }) 
    }
    
    func dismiss() {
        
        isShow = false
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.direction == .left {
                self.frame.origin.x = self.minX
            } else {
                self.frame.origin.x = self.maxX
            }
            self.bgV?.backgroundColor = UIColor.black.withAlphaComponent(0)
        }, completion: { (flag) in
            self.bgV?.removeFromSuperview()
        }) 
    }
    
    func switchShowState() {
        bgVShowing()
        if isShow {
            dismiss()
        } else {
            show()
        }
    }
    
    func bgVShowing() {
        if bgV == nil {return}
        if bgV?.superview == nil {
            superview?.insertSubview(bgV!, belowSubview: self)
        }
        bgV?.backgroundColor = bgVColor
    }
    
    override func removeFromSuperview() {
        superview?.removeGestureRecognizer(screenPan)
        super.removeFromSuperview()
    }
    
    enum Direction {
        case left, right
    }
    
}
