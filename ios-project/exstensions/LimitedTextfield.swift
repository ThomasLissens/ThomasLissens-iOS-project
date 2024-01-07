//
//  LimitedTextfield.swift
//  ios-project
//
//  Created by Thomas Lissens on 06/01/2024.
//

import Foundation
import Combine
import SwiftUI

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast()).uppercased()
            }
        }
        return self
    }
}
