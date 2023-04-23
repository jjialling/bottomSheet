//
//  ViewController.swift
//  bottomSheet
//
//  Created by 蔡佳玲 on 2021/8/21.
//

import UIKit
import SnapKit


class ViewController: UIViewController{
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: .zero)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var bottomSheet: myBottomSheetView = {
        let bottomSheet = myBottomSheetView(contentView: self.scrollView, targetView: self.view, targetViewController: self)
        return bottomSheet
    }()
    
    private var showButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(press), for: .touchUpInside)
        btn.setTitle("Show", for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    private let descView = UIView()

    private var txt: UILabel = {
        let txt = UILabel()
        txt.text = "item1\nitem2\nitem3"
        txt.numberOfLines = 0
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI()  {
        view.backgroundColor = .white
        view.addSubview(showButton)
        setupBottomSheet()
        scrollView.addSubview(descView)
        descView.addSubview(txt)
        showButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        descView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView).offset(-20)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        txt.snp.makeConstraints { (make) in
            make.left.right.equalTo(descView)
            make.top.equalTo(descView)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupBottomSheet()  {
        view.addSubview(bottomSheet)
        bottomSheet.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    @objc func press() {
        view.backgroundColor = .lightGray
        UIView.animate(withDuration: 0.25) {
            self.bottomSheet.snp.updateConstraints { make in
                make.height.equalTo(self.bottomSheet.currentContainerHeight)
            }
            self.view.layoutIfNeeded()
        }
    }
    
}

