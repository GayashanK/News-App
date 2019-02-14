//
//  ViewController.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/13/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SDWebImage

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            // register table nibs
            let nib = UINib(nibName: CellIdentifier.articleTC.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: CellIdentifier.articleTC.rawValue)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isInternetAvailable() {
            self.getArticles(countryCode: CountryCodes.UnitedStatus.rawValue)
        } else {
            activityIndicator.stopAnimating()
            Utils.instance.showAlert(title: nil, message: ValidationHelper.instance.getErrorMessage(errorCode: respond.noInternet.rawValue), viewController: self, handler: nil)
        }
        
    }
    
    //MARK: - Network Calls
    // Download articles
    private func getArticles(countryCode:String!)
    {
        let url = (NetworkConst.baseUrl + "/v2/top-headlines?country=\(String(describing: countryCode!))&apiKey=\("d6da863f882e4a1a89c5152bd3692fb6")")
      
        Alamofire.request(url, method: .get).responseObject{(response: DataResponse<ArticleResponse>) in
            switch(response.result)
            {
            case .success(_):
                if(response.result.value?.status == "ok"){
                    self.articles = (response.result.value?.articles)!
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadWithAnimation()
                } else {
                    // Fail fetch data
                    self.activityIndicator.stopAnimating()
                    Utils.instance.showAlert(title: nil, message: ValidationHelper.instance.getErrorMessage(errorCode: respond.dataFetchFailed.rawValue), viewController: self, handler: nil)
                }
                break
            case .failure(_):
                if let error = response.result.error
                {
                    print(error)
                    self.activityIndicator.stopAnimating()
                    Utils.instance.showAlert(title: nil, message: ValidationHelper.instance.getErrorMessage(errorCode: respond.dataFetchFailed.rawValue), viewController: self, handler: nil)
                }
                break
            }
        }
    }
}

//MARK: - Delegates and Datasources
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleTableViewCell.self), for: indexPath) as! ArticleTableViewCell
        
        let article = articles[indexPath.row]
        
        if(Reachability.isInternetAvailable())
        {
            if let url = article.urlToImage {
                cell.imgView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "placeholder"))
            }
        }
        if let title = article.title {
            cell.titleLbl.text = title
        }
        if let time = article.publishedAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.autoupdatingCurrent
            let date = dateFormatter.date(from: time)
            
            cell.timeView.text = Utils.instance.dateDiff(oriDate: date ?? Date(), lang: Language.english.rawValue)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow?(articles[indexPath.row])
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

