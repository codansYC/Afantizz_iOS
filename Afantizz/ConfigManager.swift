//
//  BaseConfigManager.swift
//  Afantizz
//
//  Created by yuanchao on 2018/2/11.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit

struct ConfigManager {
    
    static var baseConfig: BaseConfig?
    
    /*
     * 请求基础配置
     */
    static func obtainBaseConfig(_ completion: EmptyClosure? = nil) {
        setMemoryConfigFromDisk()
        BaseConfig.request(url: ServerUrl.baseConfig, params: nil, success: { (config) in
            if let config = config {
                updateBaseConfig(config)
            }
            completion?()
        }, error: { (error) in
            completion?()
        }) {
            completion?()
        }
    }
    
    /*
     * 读取磁盘中的config 赋值给内存中config
     */
    static func setMemoryConfigFromDisk() {
        if let data = UserDefaults.standard.data(forKey: UserDefaultsKey.baseConfig) {
            baseConfig = try? JSONDecoder().decode(BaseConfig.self, from: data)
        }
    }
    
    /*
     * 更新基础配置
     */
    static func updateBaseConfig(_ config: BaseConfig) {
        baseConfig = config
        let data = try? JSONEncoder().encode(config)
        UserDefaults.standard.set(data, forKey: UserDefaultsKey.baseConfig)
    }
}
