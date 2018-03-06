//
//  String+Expand.swift
//  AppSigner
//
//  Created by CainGoodbye on 06/03/2018.
//  Copyright © 2018 Daniel Radtke. All rights reserved.
//

import Foundation

func currExecuteablePath() -> String {
    let pPath = UnsafeMutablePointer<Int8>.allocate(capacity: 512)
    let pSize = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
    pSize.initialize(to: 512)
    _NSGetExecutablePath(pPath, pSize)
    let path = String(cString:pPath)
    pPath.deinitialize()
    pSize.deinitialize()
    
    return path.replacingOccurrences(of: path.split(separator: "/").last!, with: "")
}

extension String {
    func expandToFullPath()-> String {
        if self.hasPrefix("./") {
            return self.replacingOccurrences(of: "./", with: currExecuteablePath())
        } else if self.hasPrefix("/") {
            return self
        }
        let path = currExecuteablePath() + self
        return path.replacingOccurrences(of: "./", with: "")
    }
}
