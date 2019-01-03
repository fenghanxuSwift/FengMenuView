//
//  chooseCategroyView.swift
//  B7iOSShop
//
//  Created by fenghanxu on 2017/6/15.
//  Copyright © 2017年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit
import SnapKit

public protocol ChooseCategroyViewDataSource: NSObjectProtocol {
  func chooseCategroyView(view:ChooseCategroyView ,select classModel: String, indexPath: IndexPath)
}

public class ChooseCategroyView: MaskView {
  
 fileprivate let screenHeight = UIScreen.main.bounds.height

 public weak var dataSource: ChooseCategroyViewDataSource?

 fileprivate let tableView = UITableView(frame: CGRect.zero, style: .plain)

  public var layoutTop: CGFloat = 0 {
    didSet{
      if layoutTop == oldValue { return }
      tableView.snp.updateConstraints { (make) in
        make.top.equalToSuperview().offset(layoutTop)
      }
    }
  }
    
  public var layoutLeft: CGFloat = 0 {
    didSet{
        if layoutLeft == oldValue { return }
        tableView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(layoutLeft)
        }
    }
  }
    
  public var layoutWidth: CGFloat = 0{
    didSet{
        if layoutWidth == oldValue { return }
        tableView.snp.updateConstraints { (make) in
            make.width.equalTo(layoutWidth)
        }
    }
  }
  
  public var tableViewCellHeight: CGFloat = 40
  
  public var viewHeight:CGFloat = 0{
    didSet{
      if viewHeight != oldValue {
        tableView.reloadData()
        tableView.snp.updateConstraints({ (make) in
          make.height.equalTo(viewHeight)
        })
      }
    }
  }

  public var classes = [String]()
  
  public func show(viewRect: CGRect, top: CGFloat, width:CGFloat, cellHeight:CGFloat){
    //设置顶部距离
    layoutTop = viewRect.origin.y + viewRect.height + top
    //设置左边的距离
    layoutLeft = viewRect.origin.x
    //设置宽度
    layoutWidth = width
    //tableViewCell的高度
    tableViewCellHeight = cellHeight
    //计算cell的高度
    viewHeight = cellHeight * CGFloat(classes.count) > screenHeight - layoutTop - 5 ? screenHeight - layoutTop - 5 : cellHeight * CGFloat(classes.count)
    //显示View
    super.show()
  }


  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    buildUI()
  }

}

extension ChooseCategroyView {
  fileprivate func buildUI() {
    addSubview(tableView)
    buildSubView()
    buildLayout()
  }

  fileprivate func buildSubView() {
    tableView.backgroundColor = UIColor.white
    tableView.separatorInset = UIEdgeInsets.zero
    tableView.layoutMargins = UIEdgeInsets.zero
    tableView.separatorColor = UIColor.darkText
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "kUITableViewCell")
    tableView.delegate = self
    tableView.dataSource = self
    tableView.layer.borderColor = UIColor.gray.cgColor
    tableView.layer.borderWidth = 1
    tableView.layer.cornerRadius = 2
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
  }

  fileprivate func buildLayout(){
    tableView.snp.makeConstraints { (make) in
      make.left.equalToSuperview().offset(15)
      make.top.equalToSuperview().offset(screenHeight * 0.18)
      make.width.equalTo(100)
      make.height.equalTo(1)
    }
  }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension ChooseCategroyView: UITableViewDelegate,UITableViewDataSource {

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return classes.count
  }
  
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableViewCellHeight
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "kUITableViewCell", for: indexPath)
    let model = classes[indexPath.item]
    cell.textLabel?.text = model
    cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
    cell.textLabel?.numberOfLines = 1
    cell.textLabel?.textAlignment = .center
    return cell
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    dataSource?.chooseCategroyView(view: self, select: classes[indexPath.item], indexPath: indexPath)
    endShow()
  }

}


