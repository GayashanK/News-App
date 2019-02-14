//
//  ViewController.swift
//  StaterPack-iOS-swift-4.0
//
//  Created by Kasun Gayashan on 2/7/18.
//  Copyright © 2018 Bhasha. All rights reserved.
//

import UIKit

enum respond : String {
    case loading = "loading"
    case success = "SUCCESS"
    case authFailed = "AUTH_FAILED"
    case recordNotExists = "-404"
    case noInternet = "-1009"
    case dataFetchFailed = "3"
    case requestTimedout = "-1001"
    case severOperationFailed = "-1003"
    case couldNotConnectServer = "-1004"
    case connectionLost = "-1005"
    
    case passwrdEmpty = "PASSWORD_EMPTY"
    case passwordMinLength = "PASSWORD_MUST_HAVE_AT_LEAST_8_CHARACTERS"
    case passwordNotMatch = "PASSWORD_NOT_MATCH"
    
    case phoneNoEmpty = "PHONENO_EMPTY"
    case phoneNoMinLength = "PHONENO_MUST_HAVE_AT_LEAST_10_CHARACTERS"
    
    case `default`
}

enum ViewControllerIdentifier : String {
    case baseVC = "ClassifiedBaseViewController"
    case homeVC = "HomeViewController"
    case franceArticlesVC = "FranceArticlesViewController"
    case germanArticlesVC = "GermanArticlesViewController"
    case articleVC = "ArticleViewController"
    case sourceVC = "SourceViewController"
    case searchVC = "SearchViewController"
    case searchResultsVC = "SearchResultsViewController"
    case publishersVC = "PublishersViewController"
}

enum NavigationControllerIdentifier: String {
    case navigationController = "NavigationController"
}

enum StoryboardIdentifier : String {
    case main = "Main"
}

enum StoryboardSegueIdnetifier: String {
    case segue = "Segue"
}

enum CellIdentifier : String {
    case articleTC = "ArticleTableViewCell"
    case ArticleTH = "ArticleTableViewHeader"
    case ArticleContentTC = "ArticleContentTableViewCell"
    case publisherTC = "PublisherTableViewCell"
}

enum Language: String {
    case sinhala = "si"
    case english = "en"
}

enum CountryCodes: String {
    case UnitedStatus = "us"
    case Germany = "de"
    case France = "fr"
}

enum WSCacheKeys {
    case news    
    var value:String {
        switch self {
        case .news:
            return  "News"
        }
    }
}
