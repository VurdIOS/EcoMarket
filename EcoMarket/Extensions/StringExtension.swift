//
//  StringExtension.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 18.12.2023.
//

import UIKit

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
