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
    
   // Declare bottomSheet
    private lazy var bottomSheet1: myBottomSheetView = {
        let bottomSheet = myBottomSheetView(contentView: self.scrollView, targetView: self.view, targetViewController: self)
        return bottomSheet
    }()
    private lazy var bottomSheet2: myBottomSheetView = {
        let bottomSheet = myBottomSheetView(contentView: self.scrollView, targetView: self.view, targetViewController: self)
        return bottomSheet
    }()
    private lazy var bottomSheet3: myBottomSheetView = {
        let bottomSheet = myBottomSheetView(contentView: self.scrollView, targetView: self.view, targetViewController: self)
        return bottomSheet
    }()
    
    private var showButton1: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(press1), for: .touchUpInside)
        btn.setTitle("Normal", for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    private var showButton2: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(press2), for: .touchUpInside)
        btn.setTitle("Title", for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    private var showButton3: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(press3), for: .touchUpInside)
        btn.setTitle("CustomNav", for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    private let maskBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    
    private let descView = UIView()

    private var txt: UILabel = {
        let txt = UILabel()
        txt.text = "item1\nitem2\nitem3\nitem2\nitem3\nitem2\nitem3\nitem2\nitem3\nitem2\nitem3\nitem2\nitem3\nitem2\nitem3\nitem2\nitem3"
        txt.numberOfLines = 0
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Setup BottomSheet in viewDidLoad
        setupBottomSheet1()
        setupBottomSheet2()
        setupBottomSheet3()
    }
    
    private func configureUI()  {
        view.backgroundColor = .systemGray6
        view.addSubview(showButton1)
        view.addSubview(showButton2)
        view.addSubview(showButton3)
        view.addSubview(maskBackgroundView)
        scrollView.addSubview(descView)
        descView.addSubview(txt)
        showButton1.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        showButton2.snp.makeConstraints { (make) in
            make.top.equalTo(showButton1.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        showButton3.snp.makeConstraints { (make) in
            make.top.equalTo(showButton2.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        maskBackgroundView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        descView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-20)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        txt.snp.makeConstraints { (make) in
            make.left.right.equalTo(descView)
            make.top.equalTo(descView)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupBottomSheet1()  {
        // Customization
        bottomSheet1.mininumHeight = 200
        bottomSheet1.maximumHeight = 600
        bottomSheet1.dismissibleHeight = 150
        bottomSheet1.bgColor = .magenta
        bottomSheet1.cornerRadius = 10
        bottomSheet1.bottomSheetViewMode = .normal
        
    }
    func setupBottomSheet2()  {
        bottomSheet2.mininumHeight = 100
        bottomSheet2.maximumHeight = 500
        bottomSheet2.dismissibleHeight = 150
        bottomSheet2.cornerRadius = 10
        bottomSheet2.title = "Create"
        bottomSheet2.bottomSheetViewMode = .title
    }
    func setupBottomSheet3()  {
        bottomSheet3.mininumHeight = 300
        bottomSheet3.maximumHeight = 500
        bottomSheet3.dismissibleHeight = 150
        bottomSheet3.cornerRadius = 10
        bottomSheet3.bottomSheetViewMode = .customNav
        let v = UIView()
        v.backgroundColor = .cyan
        bottomSheet3.navgationView = v
    }
    
    @objc func press1() {
        maskBackgroundView.isHidden = false
        // Present
        bottomSheet1.present()
        bottomSheet1.dismissCompletion = {
            self.maskBackgroundView.isHidden = true
        }
    }
    
    @objc func press2() {
        maskBackgroundView.isHidden = false
        bottomSheet2.present()
        bottomSheet2.dismissCompletion = {
            self.maskBackgroundView.isHidden = true
        }
    }
    
    @objc func press3() {
        maskBackgroundView.isHidden = false
        bottomSheet3.present()
        bottomSheet3.dismissCompletion = {
            self.maskBackgroundView.isHidden = true
        }
    }
    
}

