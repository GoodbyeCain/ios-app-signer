//
//  main.swift
//  AppSigner
//
//  Created by CainGoodbye on 05/03/2018.
//  Copyright © 2018 Daniel Radtke. All rights reserved.
//

import Foundation

func doProgram() {
    let argCount = CommandLine.argc
    let arguments = CommandLine.arguments
    let consoleIO = ConsoleIO();
    
    if argCount <= 2 || argCount % 2 == 0 {
        consoleIO.printUsage()
    } else {
        var index = 1
        
        let signer = AppSigner()
        while(index < arguments.count) {
            let argument = arguments[index]
            if argument.count != 2 {
                consoleIO.writeMessage("unknow argument: \(argument)", to: OutputType.error)
                return
            }
            
            let option = OptionType(value: argument.substring(from: argument.index(argument.startIndex, offsetBy: 1)))
            let value = arguments[index + 1]
            switch option {
            case .input:
                signer.inputFile = value.expandToFullPath()
            case .output:
                signer.outputFile = value.expandToFullPath()
            case .profile:
                signer.profileFilename = value.expandToFullPath()
            case .certificate:
                signer.signingCertificate = value
            case .bundleID:
                signer.newApplicationID = value
            case .displayName:
                signer.newDisplayName = value
            case .version:
                signer.newVersion = value
            case .versionShort:
                signer.newShortVersion = value
            case .unknown:
                consoleIO.writeMessage("unknow argument: \(argument) with value:\(value)", to: OutputType.error)
                return
            }
            index += 2
        }
        
        print(signer)
        signer.doSign()
    }
}

doProgram()
