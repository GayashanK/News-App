//
//  ArticleViewController.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/13/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import UIKit

class ArticleViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            // register table nibs
            var nib = UINib(nibName: CellIdentifier.ArticleContentTC.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: CellIdentifier.ArticleContentTC.rawValue)
            nib = UINib(nibName: CellIdentifier.ArticleTH.rawValue, bundle: nil)
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: CellIdentifier.ArticleTH.rawValue)
            
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    var article : Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Delegates and Datasources
extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (UIScreen.main.bounds.width/4) * 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleContentTableViewCell.self), for: indexPath) as! ArticleContentTableViewCell
        cell.selectionStyle = .none
        cell.contentTextView.text = article.content
        cell.sourceButton.addTarget(self, action: #selector(pushToSource), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellIdentifier.ArticleTH.rawValue) as! ArticleTableViewHeader
        if(Reachability.isInternetAvailable())
        {
            if let url = article.urlToImage {
                view.imgView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "placeholder"))
            }
        }
        if let title = article.title {
            view.titleView.text = title
        }
        
        if let source = article.source?.name {
            view.sourceLbl.text = source
        }
        
        if let author = article.author {
            view.authorLbl.text = author
        }
        
        return view
    }
    
    @objc func pushToSource(){
        let storyboard = UIStoryboard(name: StoryboardIdentifier.main.rawValue, bundle: nil)
        if let sourceVC = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.sourceVC.rawValue) as? SourceViewController
        {
            sourceVC.url = article.url
            self.navigationController?.pushViewController(sourceVC, animated: true)
        }
    }
}

