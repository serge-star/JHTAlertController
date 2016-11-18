//
//  JHTAlertAnimation.swift
//  JHTAlertController
//
//  Created by Jessel, Jeremiah on 11/15/16.
//  Copyright © 2016 Jacuzzi Hot Tubs, LLC. All rights reserved.
//

import UIKit

public class JHTAlertAnimation : NSObject, UIViewControllerAnimatedTransitioning {
   
   let isPresenting: Bool
   
   init(isPresenting: Bool) {
      self.isPresenting = isPresenting
   }
   
   public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return isPresenting ? 0.2 : 0.2
   }
   
   public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      if isPresenting {
         self.presentAnimateTransition(transitionContext)
      } else {
         self.dismissAnimateTransition(transitionContext)
      }
   }
   
   func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
      
      guard let alertController = transitionContext.viewController(forKey: .to) as? JHTAlertController else {
         return
      }
      
      let containerView = transitionContext.containerView
      containerView.addSubview(alertController.view)
      containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
      containerView.alpha = 0
      
      alertController.view.alpha = 0.0
      alertController.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
      
      UIView.animate(withDuration:self.transitionDuration(using: transitionContext), animations: {
         alertController.view.alpha = 1.0
         containerView.alpha = 1.0
         alertController.view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
      }, completion: { _ in
         UIView.animate(withDuration: 0.2, animations: {
            alertController.view.transform = CGAffineTransform.identity
         }, completion: { _ in
            
            transitionContext.completeTransition(true)
            
         })
      })
   }
   
   func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
      let alertController = transitionContext.viewController(forKey: .from) as! JHTAlertController
      let containerView = transitionContext.containerView
      
      UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
         alertController.view.alpha = 0.0
         containerView.alpha = 0.0
      }, completion: { _ in
         transitionContext.completeTransition(true)
      })
      
   }
   
   
}