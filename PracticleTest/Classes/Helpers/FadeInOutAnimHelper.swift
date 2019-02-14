//
//  ViewController.swift
//  StaterPack-iOS-swift-4.0
//
//  Created by Kasun Gayashan on 2/7/18.
//  Copyright © 2018 Bhasha. All rights reserved.
//

import UIKit
import Foundation

enum FadeInOutAnimSizeRelationship{
    case ShrinkedAndOrdinary
    case ExpandedAndOrdinary
}

fileprivate let ANIM_DURATION: TimeInterval = 0.23

class FadeInOutAnimHelper{
    
    public static func prepareForInAnimation(containerView: UIView, sizeRelationship: FadeInOutAnimSizeRelationship){
        var applyingTransform: CGAffineTransform!
        if sizeRelationship == .ExpandedAndOrdinary{
            applyingTransform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        else{
            applyingTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
        containerView.alpha = 0.0
        containerView.transform = applyingTransform
    }
    
    public static func prepareForInAnimation(views: [UIView], sizeRelationship: FadeInOutAnimSizeRelationship){
        for view in views{
            self.prepareForInAnimation(containerView: view, sizeRelationship: sizeRelationship)
        }
    }
    
    public static func doInAnimation(forContainerView: UIView, completion: (() -> ())? = nil){
        
        UIView.animate(
            withDuration: ANIM_DURATION,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: {
                let normalTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                forContainerView.transform = normalTransform
                forContainerView.alpha = 1.0
        }) { (completed) in
            if completed{
                if let completionHandler = completion{
                    completionHandler()
                }
            }
        }
    }
    
    public static func doInAnimation(forViews: [UIView], completion: (() -> ())? = nil){
        
        UIView.animate(
            withDuration: ANIM_DURATION,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: {
                let normalTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
                for view in forViews{
                    view.transform = normalTransform
                    view.alpha = 1.0
                }
        }) { (completed) in
            if completed{
                if let completionHandler = completion{
                    completionHandler()
                }
            }
        }
    }
    
    public static func doOutAnimation(forContainerView: UIView, sizeRelationship: FadeInOutAnimSizeRelationship, completion: (() -> ())? = nil){
        
        UIView.animate(
            withDuration: ANIM_DURATION,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: {
                var applyingTransform: CGAffineTransform
                if sizeRelationship == .ExpandedAndOrdinary{
                    applyingTransform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }
                else{
                    applyingTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }
                
                forContainerView.transform = applyingTransform
                forContainerView.alpha = 0.0
        }) { (completed) in
            if completed{
                if let completionHandler = completion{
                    completionHandler()
                }
            }
        }
    }
    
    public static func doOutAnimation(forViews: [UIView], sizeRelationship: FadeInOutAnimSizeRelationship, completion: (() -> ())? = nil){
        
        UIView.animate(
            withDuration: ANIM_DURATION,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: {
                var applyingTransform: CGAffineTransform
                if sizeRelationship == .ExpandedAndOrdinary{
                    applyingTransform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }
                else{
                    applyingTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }
                
                for view in forViews{
                    view.transform = applyingTransform
                    view.alpha = 0.0
                }
        }) { (completed) in
            if completed{
                if let completionHandler = completion{
                    completionHandler()
                }
            }
        }
    }
    
}
