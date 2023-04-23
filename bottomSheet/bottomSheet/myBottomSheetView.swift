//
//  BottomSheetViewController.swift
//  bottomSheet
//
//  Created by 蔡佳玲 on 2021/9/1.
//

import SnapKit
import UIKit

class myBottomSheetView: UIView {
    
    var dismissibleHeight: CGFloat = 250
    var maximumContainerHeight: CGFloat = (UIScreen.main.bounds.height) - 76
    var currentContainerHeight: CGFloat = 290
    private var defaultHeight: CGFloat = 290  {
        didSet {
            defaultHeight = currentContainerHeight
        }
    }
    private var heightConstraint: Constraint?
    private var targetView: UIView
    private var contentView: UIScrollView
    private var targetViewController: UIViewController
    
    var finish: (() -> Void)?
    

    init(contentView: UIScrollView, targetView: UIView, targetViewController: UIViewController) {
        self.contentView = contentView
        self.targetView = targetView
        self.targetViewController = targetViewController
        super.init(frame: .zero)
        setupUI()
        setupPanGesture()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().priority(999)
        }
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        self.addGestureRecognizer(panGesture)
    }

    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight {
                self.snp.updateConstraints { make in
                    make.height.equalTo(newHeight)
                }
                self.targetView.layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                animateDismissView()
            }
            else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }

    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.self.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
            self.targetView.layoutIfNeeded()
        }
        currentContainerHeight = height
    }

    func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.targetView.layoutIfNeeded()
        } completion: { _ in
            self.targetView.backgroundColor = .white
        }
    }

}
