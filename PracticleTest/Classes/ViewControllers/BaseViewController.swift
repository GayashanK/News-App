//
//  ViewController.swift
//  StaterPack-iOS-swift-4.0
//
//  Created by Kasun Gayashan on 2/7/18.
//  Copyright © 2018 Bhasha. All rights reserved.
//

import UIKit

// Base Class of UIViewController for This App - All UIViewControllers are inherited from this class
class BaseViewController: UIViewController {

    // check whether app launched first time
    public var isLaunchedBefore: Bool? = false
    
    var didSelectRow: ((Article) -> Void)?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        isLaunchedBefore = isAppAlreadyLaunchedOnce()
        self.setUpBackNavigationButton(image: #imageLiteral(resourceName: "ico_left_arrow"))
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // check whether app launch first time
    public func isAppAlreadyLaunchedOnce()->Bool
    {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce")
        {
            print("App already launched")
            return true
        }else
        {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    //MARK: - Navigation Items
    public func setUpBackNavigationButton(image: UIImage, color: UIColor? = nil)
    {
        let menuUIBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(pushToBack))
        if let buColor = color
        {
            menuUIBarButtonItem.tintColor = buColor
        }else
        {
            menuUIBarButtonItem.tintColor = UIColor.white
        }
        self.navigationItem.leftBarButtonItem  = menuUIBarButtonItem
    }
    
    public func setUpRightNavigationButton(image: UIImage, color: UIColor? = nil)
    {
        let menuUIBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(pushAction))
        if let buColor = color
        {
            menuUIBarButtonItem.tintColor = buColor
        }else
        {
            menuUIBarButtonItem.tintColor = UIColor.white
        }
        self.navigationItem.rightBarButtonItem  = menuUIBarButtonItem
    }
    
    @objc func pushToBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pushAction()
    {
        
    }
    
    // MARK: - Tap Gesture Recognizer
    public func setGestureRecognizer() -> UITapGestureRecognizer
    {
        var tapRecognizer = UITapGestureRecognizer()
        tapRecognizer = UITapGestureRecognizer (target: self, action: #selector(BaseViewController.handleTapGesture(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        return tapRecognizer
    }
    
    @objc func handleTapGesture(_ tapGesture : UITapGestureRecognizer)
    {
    
    }
    
    //MARK: - Offline Management
    public func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
