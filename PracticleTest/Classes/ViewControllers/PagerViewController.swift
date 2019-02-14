//
//  ViewController.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/13/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import UIKit
import Pager

class PagerViewController: PagerController, PagerDataSource {
    
    // page titles in PagerController
    private var titles: [String] = ["USA", "German", "France"]
 
    //MARK :- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News Digest"
        self.dataSource = self
        
        // initialize viewcontrollers in PagerController
        let storyboard = UIStoryboard(name: StoryboardIdentifier.main.rawValue, bundle: nil)
        let controller1 = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.homeVC.rawValue) as? HomeViewController
        let controller2 = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.germanArticlesVC.rawValue) as! GermanArticlesViewController
        let controller3 = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.franceArticlesVC.rawValue) as! FranceArticlesViewController
        
        // Setting up the PagerController with Name of the Tabs and their respective ViewControllers
        self.setupPager(
            tabNames: titles,
            tabControllers: [controller1!, controller2, controller3])
        
        customizeTab()
        setUpRightNavigationButton(image: #imageLiteral(resourceName: "Ico_search"))
        setUpLeftNavigationButton(image: #imageLiteral(resourceName: "ico_menu"))
        
//        if let controller = controller1 {
//            controller.didSelectRow = { [weak self] (article: Article) in
//                let storyboard = UIStoryboard(name: StoryboardIdentifier.main.rawValue, bundle: nil)
//                if let articleVC = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.articleVC.rawValue) as? ArticleViewController
//                {
//                    articleVC.article = article
//                    self?.navigationController?.pushViewController(articleVC, animated: true)
//                }
//            }
//        }
        
        openArticle(controller: controller1)
        openArticle(controller: controller2)
        openArticle(controller: controller3)
    }
    
    func openArticle(controller: BaseViewController!){
        if let controller = controller {
            controller.didSelectRow = { [weak self] (article: Article) in
                let storyboard = UIStoryboard(name: StoryboardIdentifier.main.rawValue, bundle: nil)
                if let articleVC = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.articleVC.rawValue) as? ArticleViewController
                {
                    articleVC.article = article
                    self?.navigationController?.pushViewController(articleVC, animated: true)
                }
            }
        }
    }
    
    func customizeTab() {
        indicatorColor = UIColor(hex: "0x37456E")
        tabsViewBackgroundColor = UIColor(hex: "0x191919")
        contentViewBackgroundColor = UIColor.gray.withAlphaComponent(0.32)
        
        startFromSecondTab = false
        centerCurrentTab = true
        tabLocation = PagerTabLocation.top
        tabHeight = 49
        tabOffset = 0.0
        tabWidth = (UIScreen.main.bounds.width)/3
        fixFormerTabsPositions = false
        fixLaterTabsPosition = false
        animation = PagerAnimation.during
        selectedTabTextColor = .white
        tabsTextFont = Config.setFont(size: 13, weight: FontWeight.regular)
    }
    
    public func setUpRightNavigationButton(image: UIImage, color: UIColor? = nil)
    {
        let menuUIBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(pushSearch))
        if let buColor = color
        {
            menuUIBarButtonItem.tintColor = buColor
        }else
        {
            menuUIBarButtonItem.tintColor = UIColor.white
        }
        self.navigationItem.rightBarButtonItem  = menuUIBarButtonItem
    }
    
    public func setUpLeftNavigationButton(image: UIImage, color: UIColor? = nil)
    {
        let menuUIBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(pushMenu))
        if let buColor = color
        {
            menuUIBarButtonItem.tintColor = buColor
        }else
        {
            menuUIBarButtonItem.tintColor = UIColor.white
        }
        self.navigationItem.leftBarButtonItem  = menuUIBarButtonItem
    }
    
    @objc func pushMenu(){
        if let publishersVC = storyboard!.instantiateViewController(withIdentifier: ViewControllerIdentifier.publishersVC.rawValue) as? PublishersViewController{
            self.navigationController?.pushViewController(publishersVC, animated: true)
        }
    }
    
    @objc func pushSearch(){
        let popOverVC = UIStoryboard(name: StoryboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: ViewControllerIdentifier.searchVC.rawValue) as! SearchViewController
        popOverVC.modalPresentationStyle = .overCurrentContext
        popOverVC.searchVCDelegate = self
        self.present(popOverVC, animated: false, completion: nil)
    }
}

extension PagerViewController: SearchVCDelegate
{
    func searchAd(keyword: String?, start: String?, end: String?, sortOption: String?) {
        if let srVC = storyboard!.instantiateViewController(withIdentifier: ViewControllerIdentifier.searchResultsVC.rawValue) as? SearchResultsViewController{
            srVC.keyword = keyword
            srVC.startDate = start
            srVC.endDate = end
            srVC.sortOption = sortOption

            self.navigationController?.pushViewController(srVC, animated: true)
        }
    }
    
    
}
