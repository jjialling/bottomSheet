//
//  coustomBottomSheet.swift
//  bottomSheet
//
//  Created by 蔡佳玲 on 2021/8/25.
//

import UIKit
import SnapKit


enum MMCardState {
    case expandedAll
    case expandedMiddle
    case collapsed
}

class CustomBottomSheet: UIViewController {
    

    let ScreenWidth = UIScreen.main.bounds.width
    let ScreenHeight = UIScreen.main.bounds.height
    
    var nextState: MMCardState = .expandedMiddle

    final let paddingHeight: CGFloat = 20
    final let animationDuration: TimeInterval = 0.6

    var cardHeight: CGFloat {
       return ScreenHeight
    }
    
    var cardInTheMiddleHeight: CGFloat {
        return ScreenHeight - cardImageHeight
    }

    var cardHandleAreaHeight: CGFloat = 150

    var cardImageHeight: CGFloat {
        return ScreenWidth
    }

    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    

   
     lazy var bottomView: UIView = {
        let y = self.cardImageHeight - 12
        let v = UIView(frame: CGRect(x: 0, y: y, width: ScreenWidth, height: self.cardHeight))
        v.backgroundColor = .blue
        v.layer.cornerRadius = 12
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        v.layer.masksToBounds = true
        return v
    }()



     lazy var bottomScrollView: UIScrollView = {
        let v = UIScrollView()
        v.contentInsetAdjustmentBehavior = .never
        v.backgroundColor = .orange
        v.bounces = false
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureGesture()
    }
    
    func configureUI() {

        view.addSubview(bottomView)
        bottomView.addSubview(bottomScrollView)
        let height = 80 + (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0)
        bottomScrollView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-height - 32)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    func configureGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        panGesture.delegate = self
        bottomView.addGestureRecognizer(panGesture)
    }
    @objc func handleCardPan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.bottomView)
        let velocity = recognizer.velocity(in: self.bottomView)
        
        let y = self.bottomView.frame.minY
        if (y + translation.y >= 0 ) && (y + translation.y <= ScreenHeight) {
            self.bottomView.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: cardHeight)
            recognizer.setTranslation(.zero, in: self.bottomView)
           
        }
        
        if recognizer.state == .ended {
            let duration = 0.5
            if velocity.y >= 0 {
                pre()
                startInteractiveTransition(state: nextState, duration: duration)
            } else {
                next()
                startInteractiveTransition(state: nextState, duration: duration)
            }
        } else {
            //Nothing
        }
    }
    
    func pre() {
        switch nextState {
        case .collapsed:
            break
        case .expandedMiddle:
            break
        case .expandedAll:
            self.nextState = .expandedMiddle
        }
    }
    
    func next() {
        switch nextState {
        case .collapsed:
            self.nextState = .expandedMiddle
        case .expandedMiddle:
            self.nextState = .expandedAll
        case .expandedAll:
            break
        }
    }
    
    func animateTransitionIfNeeded(state: MMCardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .collapsed:
                    break
                
                case .expandedMiddle:
                    let y = self.cardImageHeight - 12
                    self.bottomView.frame = CGRect(x: 0, y: y, width: self.ScreenWidth, height: self.cardHeight)
                    self.bottomView.layer.cornerRadius = 12
                    self.bottomView.layer.masksToBounds = true
                    self.bottomScrollView.setContentOffset(.zero, animated: true)
                    
                    self.view.layoutIfNeeded()
                    
                case .expandedAll:
                    let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
                    let height = self.ScreenHeight - navigationBarHeight
                    self.bottomView.frame = CGRect(x: 0, y: 0, width: self.ScreenWidth, height: height)
                    self.bottomView.layer.cornerRadius = 0
                    self.bottomView.layer.masksToBounds = false
                    self.bottomScrollView.setContentOffset(.zero, animated: true)
                    self.bottomScrollView.isScrollEnabled = true
                    
                    self.view.layoutIfNeeded()
                }
            }
            
            frameAnimator.addCompletion { (_) in
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
        }
    }
    
    func startInteractiveTransition(state: MMCardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
    }
    

    
}
extension CustomBottomSheet: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: self.bottomView).y
        if scrollView.contentOffset.y < 12 && velocity >= 0 {
            pre()
            startInteractiveTransition(state: nextState, duration: 0.6)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: self.bottomView).y
        if scrollView.contentOffset.y < 1 && velocity >= 0 {
            pre()
            startInteractiveTransition(state: nextState, duration: 0.6)
        }
    }
}
extension CustomBottomSheet:UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let gesture = gestureRecognizer as? UIPanGestureRecognizer else { return false }
        let direction = gesture.velocity(in: bottomView).y
        
        if (nextState == .expandedAll && bottomScrollView.contentOffset.y < 12 && direction > 0) || (nextState == .expandedMiddle) {
            bottomScrollView.isScrollEnabled = false
        } else {
            bottomScrollView.isScrollEnabled = true
        }
        
        return false
    }
}
