//
//  ViewController.swift
//  FengMenuView
//
//  Created by fenghanxu on 01/03/2019.
//  Copyright (c) 2019 fenghanxu. All rights reserved.
//

import UIKit
import FengMenuView


class ViewController: UIViewController {
  
  fileprivate let Btn = UIButton()
  
  fileprivate let chooseView = ChooseCategroyView()
  
  fileprivate let nameList = ["全部分类","禽兽肉类","田园蔬菜","花果豆类","根茎瓜茄","菌菇水生","全部分类","禽兽肉类","田园蔬菜","花果豆类","根茎瓜茄","菌菇水生","全部分类","禽兽肉类","田园蔬菜","花果豆类","根茎瓜茄","菌菇水生"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    buildUI()
  }
  
  fileprivate func buildUI() {
    view.backgroundColor = UIColor.white
    view.addSubview(Btn)
    buildSubView()
    buildLayout()
    buildNavigationItem()
  }
  
  fileprivate func buildSubView() {
    Btn.setTitle("layout", for: .normal)
    Btn.setTitleColor(UIColor.blue, for: .normal)
    Btn.layer.cornerRadius = 10
    Btn.layer.masksToBounds = true
    Btn.layer.borderWidth = 0.6
    Btn.layer.borderColor = UIColor.cyan.cgColor
    Btn.addTarget(self, action: #selector(singleAndButtonClick), for: .touchUpInside)
    
    //在合适的地方传递数据带tableView里面进行显示
    chooseView.classes = nameList
    chooseView.dataSource = self
  }
  
  fileprivate func buildLayout(){
    Btn.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-200)
      make.width.equalTo(100)
      make.height.equalTo(50)
    }
  }
  
  fileprivate func buildNavigationItem(){
    
  }
  
}

extension ViewController {
  
  //点击按键出发显示控件
  @objc func singleAndButtonClick() {
    //获取参照物的参考点
    let rect = Btn.convert(Btn.bounds, to: UIApplication.shared.keyWindow)
    chooseView.show(viewRect: rect, top: 5, width: 100, cellHeight: 40)
  }
  
}

extension ViewController:ChooseCategroyViewDataSource {
  //实现代理方法
  func chooseCategroyView(view: ChooseCategroyView, select classModel: String, indexPath: IndexPath) {
    //把点击tableView的行数返回出来
    print("indexPath.item = \(indexPath.item)")
  }
}


