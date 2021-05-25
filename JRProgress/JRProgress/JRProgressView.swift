//
//  JRProgressView.swift
//  JRProgress
//
//  Created by jackfrow on 2021/5/25.
//

import UIKit

class weakProxy: NSObject {
    weak var target: NSObjectProtocol?
    init(target: NSObjectProtocol) {
           self.target = target
           super.init()
       }
    
    override func responds(to aSelector: Selector!) -> Bool {
          return (target?.responds(to: aSelector) ?? false) || super.responds(to: aSelector)
      }

      override func forwardingTarget(for aSelector: Selector!) -> Any? {
          return target
      }

}

class JRProgressView: UIView {

    
    //当前进度
    public var progress: Float = 0
    //目标进度
    private var privateProgress: Float = 0
    
    //动画持续时间
    public var animationDuration: TimeInterval = 3

    var displayLink : CADisplayLink?
    
    //进度更新动画过程中的回调，在这里可以拿到当前进度及进度条的frame
    public var completeBlock: (() -> ())?
    
    //进度条完成部分的渐变颜色，设置单个为纯色，设置多个为渐变色
    public var progressColors: [UIColor] = [] {
        didSet{
            if progressColors.count == 0 {
                gradientLayer.colors = nil
            }else{
                gradientLayer.colors = progressColors.map({ (color) -> CGColor in
                    return color.cgColor
                })
            }
        }
    }
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit()  {
        
        gradientLayer.mask = maskLayer
        layer.addSublayer(gradientLayer)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        gradientLayer.frame = bounds
        var bounds = gradientLayer.bounds
        bounds.size.width *= CGFloat(progress)
        maskLayer.frame = bounds
    
    }
    

    //MARK: - API
    public func setProgress(_ progress: Float, animated: Bool) {
        displayLink?.invalidate()
        
        let validProgress = min(1.0, max(0.0, progress))
        if privateProgress ==  validProgress{
           return
        }
        privateProgress = validProgress
        
        
        //开启CADisplayLink
        displayLink = CADisplayLink(target: weakProxy(target: self), selector: #selector(displayLinkAction))
        //使用common模式，使其在UIScrollView滑动时依然能得到回调
        displayLink?.add(to: .main, forMode: .common)
        
        
    }
    
    @objc func displayLinkAction() {
        if progress >= privateProgress {
            displayLink?.invalidate()
            displayLink = nil
            completeBlock?()
        }
        progress += Float(1.0/60)/Float(animationDuration)
        //force layout
        setNeedsLayout()
        layoutIfNeeded()
        
    }
    

    // MARK : - lazy
    lazy var gradientLayer: CAGradientLayer = {
        
        let layer = CAGradientLayer()
        layer.startPoint = .zero
        layer.endPoint = CGPoint(x: 1.0, y: 0)
        return layer
    }()
    
    lazy var maskLayer: CALayer = {
        let layer  = CALayer()
        layer.backgroundColor = UIColor.white.cgColor
        return layer
    }()
    
}
