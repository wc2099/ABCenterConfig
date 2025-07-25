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
    case successFetchedFromRemote = 0
    case successUsingPreFetchedData
    case error
}

@objc public class ABCenterConfig: NSObject {
    
    @objc public static let shared = ABCenterConfig()
    
    private var remoteConfig: RemoteConfig?
    
    private override init() {
        super.init()
        self.setUpConfig()
    }
    
    /// 公开给外部调用的初始化配置方法
    @objc public func setup() {
        // 这里可以做额外的初始化操作，如果需要
        
    }
    
    private func setUpConfig() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        self.remoteConfig?.configSettings = settings
        
        // 使用官方简化方法设置默认值
        self.remoteConfig?.setDefaults(fromPlist: "RemoteConfigDefaults")
    }
    
    /// 远程拉取并激活配置，带回调
    @objc public func fetchAndActivate(completionHandler: @escaping (RemoteConfigFetchAndActivateStatus, Error?) -> Void) {
        remoteConfig?.fetchAndActivate { status, error in
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
    
    /// 读取字符串值
    @objc public func string(forKey key: String) -> String? {
        return remoteConfig?.configValue(forKey: key).stringValue
    }
    
    /// 读取数字值
    @objc public func number(forKey key: String) -> NSNumber? {
        return remoteConfig?.configValue(forKey: key).numberValue
    }
    
    /// 读取Data值
    @objc public func data(forKey key: String) -> Data? {
        return remoteConfig?.configValue(forKey: key).dataValue
    }
    
    /// 读取布尔值
    @objc public func bool(forKey key: String) -> Bool {
        return remoteConfig?.configValue(forKey: key).boolValue ?? false
    }
    
    /// 读取JSON值
    @objc public func jsonValue(forKey key: String) -> Any? {
        return remoteConfig?.configValue(forKey: key).jsonValue
    }
}
