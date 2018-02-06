//
//  Extensions.swift
//  TV
//
//  Created by Paagiotis  Kompotis  on 05/02/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor{
        let R = r/255
        let G = g/255
        let B = b/255
        
            return UIColor(displayP3Red: R, green: G, blue: B, alpha: alpha)
    }
}


extension String {
    func plainTextFromHTML() -> String? {
        let regexPattern = "<.*?>"
        do {
            let stripHTMLRegex = try NSRegularExpression(pattern: regexPattern, options: NSRegularExpression.Options.caseInsensitive)
            let plainText = stripHTMLRegex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.count), withTemplate: "")
            return plainText
        } catch {
            print("Warning: failed to create regular expression from pattern: \(regexPattern)")
            return nil
        }
    }
}
