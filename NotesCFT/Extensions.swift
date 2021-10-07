//
//  Extensions.swift
//  NotesCFT
//
//  Created by Дмитрий Геращенко on 30.09.2021.
//

import SwiftUI

extension View {
  
  func hidekeyboard() {
    let resign = #selector(UIResponder.resignFirstResponder)
    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
  }
}

extension String {
    func stringBefore(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(prefix(upTo: index))
        } else {
            return ""
        }
    }
  
  func stringAfter(_ delimiter: Character) -> String {
          if let index = firstIndex(of: delimiter) {
              return String(suffix(from: index).dropFirst())
          } else {
            return ""
          }
      }
}

 extension String {
 func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
   let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
   let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
   let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
   let range = (self as NSString).range(of: text)
   fullString.addAttributes(boldFontAttribute, range: range)
   return fullString
 }}


//  USE CASE:
        let text = "Discover New Shops.".withBoldText(text: "New")
