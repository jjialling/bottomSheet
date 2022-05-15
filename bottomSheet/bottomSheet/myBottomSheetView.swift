//
//  BottomSheetViewController.swift
//  bottomSheet
//
//  Created by 蔡佳玲 on 2021/9/1.
//

import UIKit


public enum BottomSheetState{
    case maxDisplay
    case minDisplay
}

public class myBottomSheetView: UIView {
    
    fileprivate var minimumHeight: CGFloat = 100    // 合起來的高度
    fileprivate var maximumHeight: CGFloat = 300    // 展開的高度

    public var defaultMinimumHeight: CGFloat = 100 {
        didSet {
            minimumHeight = defaultMinimumHeight
        }
    }
    // 可調最小高度
    
    public var defaultMaximumHeight: CGFloat = 300 {
        didSet {
            maximumHeight = defaultMaximumHeight
        }
    }
    // 可調整最大高度
    
    public var displayState: BottomSheetState = .minDisplay
    
    public var triggerDistance: CGFloat = 50    // 滾動多少距離
    
    
    fileprivate var minFrame: CGRect {
        
        return CGRect(x: 0, y: self.bounds.size.height - minimumHeight+(10), width: self.bounds.size.width, height: maximumHeight)
        // 10是下面會有多的圓角效果距離
    }
    
    fileprivate var maxFrame: CGRect {
      
        return CGRect(x: 0, y: self.bounds.size.height - maximumHeight+(10), width: self.bounds.size.width, height: maximumHeight)
        
    }
    
    let contentView: UIScrollView

    public init(contentView: UIScrollView) {
        self.contentView = contentView
        super.init(frame: CGRect.zero)
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .white
        
        addSubview(contentView) // 這時觸發layoutSubviews()
        configureGesture()
       
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        if displayState == .minDisplay {
            contentView.frame = minFrame
        }else {
            contentView.frame = maxFrame
        }
    }
    
    fileprivate func configureGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(gesture:)))
        panGesture.delegate = self
        contentView.addGestureRecognizer(panGesture)
    }
    
    

    @objc fileprivate func handleCardPan(gesture: UIPanGestureRecognizer) {
        if minimumHeight == maximumHeight {
            return
        }
        switch gesture.state {
        case .changed:
            var canMoveFrame = false
            if displayState == .minDisplay {
                canMoveFrame = true
            }else  {
                if contentView.frame.origin.y > maxFrame.origin.y || contentView.contentOffset.y <= 0 {
                    canMoveFrame = true //已經滑到最上面要關起來了
                }
                
            }
            if canMoveFrame {
                let translation = gesture.translation(in: contentView)
                var frame = contentView.frame
                frame.origin.y += translation.y
                frame.origin.y = max(frame.origin.y, maxFrame.origin.y)
                frame.origin.y = min(frame.origin.y, minFrame.origin.y)
                contentView.frame = frame
            }
            gesture.setTranslation(CGPoint.zero, in: contentView)
            

            if contentView.frame.origin.y > maxFrame.origin.y ||
                (contentView.frame.origin.y == minFrame.origin.y && contentView.frame.origin.y == maxFrame.origin.y) {
                //當contentView還沒展開到最大值時，不允許滾動。
                //minimumHeight = maximumHeight也不允許內部滾動
                contentView.setContentOffset(CGPoint.zero, animated: false)
            }
            
        case .cancelled, .ended, .failed:
            let velocity = gesture.velocity(in: gesture.view)
           
            if displayState == .minDisplay {
                //這邊是判斷什麼時候要展開
                if velocity.y < 0 {
                    displayMax()
                    //使用速度判斷展開
                }else if minFrame.origin.y - contentView.frame.origin.y > triggerDistance {
                    //滾動距離來判斷
                    if velocity.y < 0 {

                        displayMax()
                    }else {

                        displayMin()
                    }
                }else {
                    displayMin()
                }
               
                contentView.setContentOffset(CGPoint.zero, animated: false)
                //不滾動
                
            }else {
                //這邊是判斷什麼時候要合起
                if velocity.y > 0 && contentView.contentOffset.y <= 0 {
                    //滑到最上面，不滾動
                    displayMin()
                    contentView.setContentOffset(CGPoint.zero, animated: false)
                }else if contentView.frame.origin.y - maxFrame.origin.y > triggerDistance {
                    if velocity.y < 0 {

                        displayMax()
                    }else {

                        displayMin()
                    }
                }else {
                    displayMax()
                }
                
            }
        default:
            break
        }
    }

    fileprivate func displayMax() {
        if contentView.frame == maxFrame {
            return
        }

        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.contentView.frame = self.maxFrame
        }) { (finished) in
            self.displayState = .maxDisplay
            

        }
    }

    fileprivate func displayMin() {
        if contentView.frame == minFrame {
            return
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.contentView.frame = self.minFrame
        }) { (finished) in
            self.displayState = .minDisplay

        }
    }
    

}

extension myBottomSheetView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}




