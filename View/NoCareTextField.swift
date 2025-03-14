//
//  NoCareTextField.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/13.
//

import Foundation
import UIKit

class NoCareTextField: UITextField {
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    
    override func canPaste(_ itemProviders: [NSItemProvider]) -> Bool {
        return false
    }
}
