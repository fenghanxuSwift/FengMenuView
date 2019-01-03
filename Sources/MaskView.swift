//
//  MaskView.swift
//  全屏蒙版封装
//
//  Created by fenghanxu on 2016/12/27.
//  Copyright © 2016年 iOS1002. All rights reserved.
//

import UIKit

public class MaskView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.black.withAlphaComponent(0.5)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    endShow()
  }

  func show() {
    self.frame = UIScreen.main.bounds
    UIApplication.shared.keyWindow?.addSubview(self)
    UIView.animate(withDuration: 0.2, animations: {
      self.alpha = 1
    })
  }

  func endShow() {
    UIApplication.shared.keyWindow?.endEditing(true)
    UIView.animate(withDuration: 0.2, animations: {
      self.alpha = 0
    })

    SPGcd.sleep(0.2, mainQueueBlock: {
      self.removeFromSuperview()
    })

  }

}

class SPGcd: NSObject {
  /// 线程延时
  class func sleep(_ time: Double,mainQueueBlock:@escaping ()->()) {
    let time = DispatchTime.now() + .milliseconds(Int(time * 1000))
    DispatchQueue.main.asyncAfter(deadline: time) {
      mainQueueBlock()
    }
  }
}

