//
//  PublishersViewController.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/14/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class PublishersViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            // register table nibs
            let nib = UINib(nibName: CellIdentifier.publisherTC.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: CellIdentifier.publisherTC.rawValue)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var publishers = [Publisher]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Article Publishers"
        if Reachability.isInternetAvailable() {
            self.getPublishers(country: CountryCodes.UnitedStatus.rawValue)
        } else {
            activityIndicator.stopAnimating()
            Utils.instance.showAlert(title: nil, message: ValidationHelper.instance.getErrorMessage(errorCode: respond.noInternet.rawValue), viewController: self, handler: nil)
        }
        
    }
    
    //MARK: - Network Calls
    // Download publishers
    private func getPublishers(country:String!)
    {
        let url = (NetworkConst.baseUrl + "/v2/sources?country=\(String(describing: country!))&apiKey=\("d6da863f882e4a1a89c5152bd3692fb6")")
        
        print(url)
        
        Alamofire.request(url, method: .get).responseObject{(response: DataResponse<PublisherResponse>) in
            switch(response.result)
            {
            case .success(_):
                if(response.result.value?.status == "ok"){
                    self.publishers = (response.result.value?.publishers)!
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
extension PublishersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publishers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PublisherTableViewCell.self), for: indexPath) as! PublisherTableViewCell
        cell.selectionStyle = .none
        let publisher = publishers[indexPath.row]
        
        if let name = publisher.name {
            cell.nameLbl.text = name
        }
        
        if let des = publisher.detail {
            cell.detailTextView.text = des
        }
        
        if let country = publisher.country {
            cell.countryLbl.text = country
        }
        
        if let category = publisher.category {
            cell.categoryLbl.text = category
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sourceVC = storyboard!.instantiateViewController(withIdentifier: ViewControllerIdentifier.sourceVC.rawValue) as? SourceViewController
        {
            sourceVC.url = publishers[indexPath.row].url
            self.navigationController?.pushViewController(sourceVC, animated: true)
        }
    }
}
