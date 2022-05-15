//
//  AddGesture.swift
//  bottomSheet
//
//  Created by 蔡佳玲 on 2021/8/25.
//

import Foundation
import UIKit

//class PanListener: UIPanGestureRecognizer, UIScrollViewDelegate, UIGestureRecognizerDelegate{
//
//
//    var onClick : (() -> Void)?
//
//    init(target: Any?, action: Selector?, onClick: (() -> Void)? = nil) {
//
//        self.onClick = onClick
//        super.init(target: target, action: action)
//    }
//
//}
//
//extension UIView {
//
//
//
//    func addPanGesture( action :@escaping () -> Void){
//        let tapRecogniser = PanListener(target: self, action: #selector(onViewClicked), onClick: action)
//
//        self.addGestureRecognizer(tapRecogniser)
//
//    }
//
//    @objc func onViewClicked(_ recognizer: PanListener) {
//        print("click")
//        let translation = recognizer.translation(in: self)
//        let velocity = recognizer.velocity(in: self)
//
//        let y = self.frame.minY
//        if (y + translation.y >= 0 ) && (y + translation.y <= ViewController().ScreenHeight) {
//            self.frame = CGRect(x: 0, y: y + translation.y, width: 390, height: ViewController().cardHeight)
//            recognizer.setTranslation(.zero, in: self)
//
//        }
//        if recognizer.state == .ended {
//
//            let duration = 0.5
//            if velocity.y >= 0 {
////                pre()
////                startInteractiveTransition(state: CustomBottomSheet().nextState, duration: duration, bottomView: self, bottomScrollView :CustomBottomSheet().bottomScrollView)
//            } else {
////                next()
////                startInteractiveTransition(state: CustomBottomSheet().nextState, duration: duration, bottomView: self, bottomScrollView :CustomBottomSheet().bottomScrollView)
//            }
//        } else {
//            //Nothing
//        }
//
//        recognizer.onClick?()
//    }
//
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let velocity = scrollView.panGestureRecognizer.velocity(in: self).y
//        if scrollView.contentOffset.y < 12 && velocity >= 0 {
////            pre()
////            startInteractiveTransition(state: CustomBottomSheet().nextState, duration: 0.6,bottomView: self, bottomScrollView :CustomBottomSheet().bottomScrollView)
//        }
//    }
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let velocity = scrollView.panGestureRecognizer.velocity(in: self).y
//        if scrollView.contentOffset.y < 1 && velocity >= 0 {
////            pre()
////            startInteractiveTransition(state: CustomBottomSheet().nextState, duration: 0.6,bottomView: self, bottomScrollView :CustomBottomSheet().bottomScrollView)
//        }
//    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        guard let gesture = gestureRecognizer as? UIPanGestureRecognizer else { return false }
//        let direction = gesture.velocity(in: self).y
//
//        if ( CustomBottomSheet().nextState == .expandedAll && CustomBottomSheet().bottomScrollView.contentOffset.y < 12 && direction > 0) || ( CustomBottomSheet().nextState == .expandedMiddle) {
//            CustomBottomSheet().bottomScrollView.isScrollEnabled = false
//        } else {
//            CustomBottomSheet().bottomScrollView.isScrollEnabled = true
//        }
//
//        return false
//    }
//}
//
