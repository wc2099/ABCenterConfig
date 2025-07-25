//
//  ABCenterConfig.swift
//  ABCenterConfig_Example
//
//  Created by jack.cai on 2025/7/25.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

@objc public enum RemoteConfigFetchAndActivateStatus: Int {
    /// The remote fetch succeeded and fetched data was activated.
    case successFetchedFromRemote = 0
    /// The fetch and activate succeeded from already fetched but yet unexpired config data.
    /// You can control this using minimumFetchInterval property in RemoteConfigSettings.
    case successUsingPreFetchedData
    /// The fetch and activate failed.
    case error
}

class PPConfigCenter {
    
    static let shared = PPConfigCenter()
    
    private var remoteConfig: RemoteConfig
    
    private init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        self.remoteConfig.configSettings = settings
        
        if let defaultsPath = Bundle.main.path(forResource: "RemoteConfigDefaults", ofType: "plist"),
           let defaults = NSDictionary(contentsOfFile: defaultsPath) as? [String: NSObject] {
            self.remoteConfig.setDefaults(defaults)
        }
    }
    
    static func setup() {
        PPConfigCenter.shared.seupConfig()
    }
    
    private func seupConfig() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        self.remoteConfig.configSettings = settings
        
        if let defaultsPath = Bundle.main.path(forResource: "RemoteConfigDefaults", ofType: "plist"),
           let defaults = NSDictionary(contentsOfFile: defaultsPath) as? [String: NSObject] {
            self.remoteConfig.setDefaults(defaults)
        }
    }
    
    /// Fetch and activate remote config with completion handler using custom enum status
    func fetchAndActivate(completionHandler: @escaping (RemoteConfigFetchAndActivateStatus, Error?) -> Void) {
        remoteConfig.fetchAndActivate { status, error in
            // Map Firebase's RemoteConfigFetchAndActivateStatus to our custom enum
            let mappedStatus: RemoteConfigFetchAndActivateStatus
            switch status {
            case .successFetchedFromRemote:
                mappedStatus = .successFetchedFromRemote
            case .successUsingPreFetchedData:
                mappedStatus = .successUsingPreFetchedData
            case .error:
                mappedStatus = .error
            @unknown default:
                mappedStatus = .error
            }
            completionHandler(mappedStatus, error)
        }
    }
    
    func string(forKey key: String) -> String? {
        return remoteConfig.configValue(forKey: key).stringValue
    }
    
    func number(forKey key: String) -> NSNumber? {
        return remoteConfig.configValue(forKey: key).numberValue
    }
    
    func data(forKey key: String) -> Data? {
        return remoteConfig.configValue(forKey: key).dataValue
    }
    
    func bool(forKey key: String) -> Bool {
        return remoteConfig.configValue(forKey: key).boolValue
    }
    
    func jsonValue(forKey key: String) -> Any? {
        return remoteConfig.configValue(forKey: key).jsonValue
    }
}
