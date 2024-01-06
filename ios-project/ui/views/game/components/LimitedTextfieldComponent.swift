//
//  LimitedTextfield.swift
//  ios-project
//
//  Created by Thomas Lissens on 06/01/2024.
//

import Foundation
import SwiftUI

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int
    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
