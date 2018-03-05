//
//  main.swift
//  AppSigner
//
//  Created by CainGoodbye on 05/03/2018.
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
    return path
}

var signer = AppSigner()

//var inputPath = "/Users/caingoodbye/Desktop/Happy/food.ipa"
var inputFile = "./food.ipa"
var outputFile = "./food_1.ipa"

if inputFile.hasPrefix("./") {
    inputFile = inputFile.replacingOccurrences(of: "./", with: currExecuteablePath())
}

if outputFile.hasPrefix("./") {
    outputFile = outputFile.replacingOccurrences(of: "./", with: currExecuteablePath())
}


signer.inputFile = inputFile
signer.outputFile = outputFile
signer.profileFilename = "/Users/caingoodbye/Desktop/Happy/profile.mobileprovision"
signer.signingCertificate = "iPhone Developer: ji gang (82JMW36TMX)"
signer.newApplicationID = ""
signer.newDisplayName = ""
signer.newVersion = ""
signer.newShortVersion = ""
signer.doSign()

