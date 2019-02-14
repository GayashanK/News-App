//
//  OfflineManager.swift
//  Classifieds
//
//  Created by Kasun Gayashan on 9/10/18.
//  Copyright © 2018 Bhasha. All rights reserved.
//

import UIKit

class OfflineManager: NSObject {
    
//    static let sharedManager = OfflineManager()
//    let LocalServiceCacheDownloadDir = "LocalData"
//
//    func getBaseForCacheLocal(with fileName:String) -> String? {
//
//        let filePath = FileManager.default.getDocumentPath(forItemName: self.LocalServiceCacheDownloadDir)
//
//        if FileManager.default.directoryExists(atPath: filePath) {
//            return filePath.stringByAppendingPathComponent(fileName)
//        } else {
//            if  FileManager.default.createDirectory(withFolderName: self.LocalServiceCacheDownloadDir) {
//                return filePath.stringByAppendingPathComponent(fileName)
//            }
//        }
//        return nil
//    }
//
//    @discardableResult
//    func cacheDataToLocal(with Object:Any,to key:WSCacheKeys) -> Bool {
//        let success = NSKeyedArchiver.archiveRootObject(Object, toFile: getBaseForCacheLocal(with: key.value)!)
//        if success {
//            print( "Local Data Cached\(String(describing: getBaseForCacheLocal(with: key.value)))")
//        } else {
//            print("Error")
//        }
//
//        return success
//    }
//
//    func loadCachedDataFromLocal(with key:WSCacheKeys ) -> Any? {
//        return NSKeyedUnarchiver.unarchiveObject(withFile: getBaseForCacheLocal(with: key.value)!) as? [ClassifiedAd]
//    }
//
//    func removeAllCacheDirs () {
//        do {
//            try FileManager.default.removeItem(atPath: self.getBaseForCacheLocal(with: "")!)
//        } catch {
//            print("error in remove dir \(error.localizedDescription)")
//        }
//    }

}
