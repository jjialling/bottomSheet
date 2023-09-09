//
//  BottomSheetViewController.swift
//  bottomSheet
//
//  Created by 蔡佳玲 on 2021/9/1.
//

import SnapKit
import UIKit

public enum myBottomSheetViewMode {
    case normal
    case title
    case customNav
}
open class myBottomSheetView: UIView {
    public var dismissibleHeight: CGFloat = 250
    public var maximumHeight: CGFloat = (UIScreen.main.bounds.height) - 76
    public var mininumHeight: CGFloat = 290
    public var cornerRadius: CGFloat = 20
    public var bgColor: UIColor = .white
    public var title: String = "AAA"
    public var navgationView: UIView?
    public var dismissCompletion: (() -> Void)?
    public var bottomSheetViewMode: myBottomSheetViewMode = .normal
    
    fileprivate var defaultHeight: CGFloat = 290  {
        didSet {
            defaultHeight = mininumHeight
        }
    }
    fileprivate var heightConstraint: Constraint?
    fileprivate var targetView: UIView
    fileprivate var contentView: UIScrollView
    fileprivate var targetViewController: UIViewController
 
    fileprivate let drugView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()

    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

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

    func present() {
        UIView.animate(withDuration: 0.25) {
            self.snp.updateConstraints { make in
                make.height.equalTo(self.mininumHeight)
            }
            self.targetView.layoutIfNeeded()
        }
        defaultHeight = mininumHeight
        self.renewLayout()
    }
    
    fileprivate func renewLayout() {
        self.backgroundColor = bgColor
        self.layer.cornerRadius = cornerRadius
        switch bottomSheetViewMode {
        case .normal:
            break
        case .title:
            self.addSubview(titleLabel)
            self.addSubview(lineView)
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(35)
                make.centerX.equalToSuperview()
                make.height.equalTo(20)
            }
            lineView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(1)
            }
            contentView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(76)
            }
        case .customNav:
            self.addSubview(navgationView ?? UIView())
            self.addSubview(lineView)
            navgationView?.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(49)
            }
            lineView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(65)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(1)
            }
            contentView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(76)
            }
        }
       
    }
    
    fileprivate func setupUI() {
        self.backgroundColor = bgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.addSubview(drugView)
        self.addSubview(contentView)
        targetView.addSubview(self)
       
        drugView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(50)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().priority(999)
        }
        self.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0)
            make.bottom.equalTo(targetView.snp.bottom)
        }
    }
    
    fileprivate func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        self.addGestureRecognizer(panGesture)
    }

    @objc fileprivate func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let isDraggingDown = translation.y > 0
        let newHeight = mininumHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight < maximumHeight {
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
            else if newHeight < maximumHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumHeight)
            }
        default:
            break
        }
    }

    fileprivate func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.self.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
            self.targetView.layoutIfNeeded()
        }
        mininumHeight = height
    }

    fileprivate func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.targetView.layoutIfNeeded()
        } completion: { _ in
            self.dismissCompletion?()
        }
    }

}
