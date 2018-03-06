/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

enum OptionType: String {
    case input = "i"
    case output = "o"
    case profile = "p"
    case certificate = "c"
    case bundleID = "b"
    case displayName = "d"
    case version = "v"
    case versionShort = "s"
    case unknown
    
    init(value: String) {
        switch value {
        case "i": self = .input
        case "o": self = .output
        case "p": self = .profile
        case "c": self = .certificate
        case "b": self = .bundleID
        case "d": self = .displayName
        case "v": self = .version
        case "s": self = .versionShort
        default: self = .unknown
        }
    }
}

func getOption(_ option: String) -> (option:OptionType, value: String) {
    return (OptionType(value: option), option)
}

enum OutputType {
	case error
	case standard
}

class ConsoleIO {
  func writeMessage(_ message: String, to: OutputType = .standard) {
    switch to {
    case .standard:
      // 1
      print("\u{001B}[;m\(message)")
    case .error:
      // 2
      fputs("\u{001B}[0;31m\(message)\n", stderr)
    }
  }
  
  func printUsage() {
    writeMessage("DESCRIPTION:")
    writeMessage("    -i input file path")
    writeMessage("    -o output file path")
    writeMessage("    -p mobile profile file path")
    writeMessage("    -c certificate file path")
    writeMessage("    -b option value, bundle ID")
    writeMessage("    -d option value, display app name")
    writeMessage("    -v option value, app version")
    writeMessage("    -s option value, app short version")
    writeMessage("EXAMPLES:")
    writeMessage("    AppSigner -i ")
  }
  
  func getInput() -> String {
    // 1
    let keyboard = FileHandle.standardInput
    // 2
    let inputData = keyboard.availableData
    // 3
    let strData = String(data: inputData, encoding: String.Encoding.utf8)!
    // 4
    return strData.trimmingCharacters(in: CharacterSet.newlines)
  }
}

