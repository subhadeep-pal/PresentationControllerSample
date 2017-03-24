//
//  SlideInPresentationAnimator.swift
//  MedalCount
//
//  Created by 01HW934413 on 24/03/17.
//  Copyright © 2017 Ron Kliffer. All rights reserved.
//

import UIKit

class SlideInPresentationAnimator: NSObject {
  
  // MARK: - Properties
  let direction: PresentationDirection
  let isPresentation: Bool
  
  
  // MARK: - Initializers
  init(direction: PresentationDirection, isPresentation: Bool) {
    self.direction = direction
    self.isPresentation = isPresentation
    super.init()
  }
}

extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
    
    let controller = transitionContext.viewController(forKey: key)!
    
    if isPresentation {
      transitionContext.containerView.addSubview(controller.view)
    }
    
    let presentedFrame = transitionContext.finalFrame(for: controller)
    var dismissalFrame = presentedFrame
    
    switch direction{
    case .left:
      dismissalFrame.origin.x = -presentedFrame.width
    case .right:
      dismissalFrame.origin.x = transitionContext.containerView.frame.size.width
    case .top:
      dismissalFrame.origin.y = -presentedFrame.height
    case .bottom:
      dismissalFrame.origin.y = transitionContext.containerView.frame.size.height
    }
    
    let initialFrame = isPresentation ? dismissalFrame : presentedFrame
    let finalFrame = isPresentation ? presentedFrame : dismissalFrame
    
    let animationDuration = transitionDuration(using: transitionContext)
    controller.view.frame = initialFrame
    
    UIView.animate(withDuration: animationDuration, animations: {
    controller.view.frame = finalFrame
    }) { finished in
      transitionContext.completeTransition(finished)
    }
  }
}
