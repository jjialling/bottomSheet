//
//  ViewController.swift
//  bottomSheet
//
//  Created by 蔡佳玲 on 2021/8/21.
//

import UIKit
import SnapKit


class ViewController: UIViewController{
    
    let screenWidth = UIScreen.main.bounds.width
   
    var scrollView:UIScrollView = {
        let sv = UIScrollView.init(frame: .zero)
        sv.contentInsetAdjustmentBehavior = .never
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let descView = UIView()

    var txt:UILabel = {
        let txt = UILabel()
        txt.text = "比方以下的例子，scroll view 本身的大小只能容納一張圖片，但它可以水平捲動，往左捲動後能看到右邊的圖片，關鍵正來自它的 content size。它的 content size 的寬度等於三張圖片加起來的寬度，所以可以容納三張圖。因此 scroll view 要能捲動有個重要的條件，它的 content size 必須大於 frame 大小，如此它才會覺得可以捲動。當 content size 的寬度大於 frame 的寬度時將可左右捲動，當 content size 的高度大於 frame 的高度時則可上下捲動。比方以下的例子，scroll view 本身的大小只能容納一張圖片，但它可以水平捲動，往左捲動後能看到右邊的圖片，關鍵正來自它的 content size。它的 content size 的寬度等於三張圖片加起來的寬度，所以可以容納三張圖。因此 scroll view 要能捲動有個重要的條件，它的 content size 必須大於 frame 大小，如此它才會覺得可以捲動。當 content size 的寬度大於 frame 的寬度時將可左右捲動，當 content size 的高度大於 frame 的高度時則可上下捲動。比方以下的例子，scroll view 本身的大小只能容納一張圖片，但它可以水平捲動，往左捲動後能看到右邊的圖片，關鍵正來自它的 content size。它的 content size 的寬度等於三張圖片加起來的寬度，所以可以容納三張圖。因此 scroll view 要能捲動有個重要的條件，它的 content size 必須大於 frame 大小，如此它才會覺得可以捲動。當 content size 的寬度大於 frame 的寬度時將可左右捲動，當 content size 的高度大於 frame 的高度時則可上下捲動。比方以下的例子，scroll view 本身的大小只能容納一張圖片，但它可以水平捲動，往左捲動後能看到右邊的圖片，關鍵正來自它的 content size。它的 content size 的寬度等於三張圖片加起來的寬度，所以可以容納三張圖。因此 scroll view 要能捲動有個重要的條件，它的 content size 必須大於 frame 大小，如此它才會覺得可以捲動。當 content size 的寬度大於 frame 的寬度時將可左右捲動，當 content size 的高度大於 frame 的高度時則可上下捲動。比方以下的例子，scroll view 本身的大小只能容納一張圖片，但它可以水平捲動，往左捲動後能看到右邊的圖片，關鍵正來自它的 content size。它的 content size 的寬度等於三張圖片加起來的寬度，所以可以容納三張圖。因此 scroll view 要能捲動有個重要的條件，它的 content size 必須大於 frame 大小，如此它才會覺得可以捲動。當 content size 的寬度大於 frame 的寬度時將可左右捲動，當 content size 的高度大於 frame 的高度時則可上下捲動。"
        txt.numberOfLines = 0
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addBottomSheet()
    }
    
    func configureUI()  {
        view.backgroundColor = .white
        scrollView.addSubview(descView)
        descView.addSubview(txt)
    
        descView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(20)
            make.bottom.equalTo(scrollView).offset(-20)
            make.width.equalTo(screenWidth)
        }
        txt.snp.makeConstraints { (make) in
            make.left.right.equalTo(descView)
            make.top.equalTo(descView)
            make.bottom.equalToSuperview() // 底部一定要，不然不能夠確定contentSize。
        }
    }
    
    func addBottomSheet()  {
        let bottomSheet = myBottomSheetView(contentView:scrollView )
        bottomSheet.defaultMaximumHeight = 200
        bottomSheet.defaultMinimumHeight = 200
        bottomSheet.displayState = .minDisplay
        bottomSheet.frame = self.view.bounds
        view.addSubview(bottomSheet)
    }
   
}

