//
//  Title.swift
//  ios-project
//
//  Created by Thomas Lissens on 02/01/2024.
//

import Foundation
import SwiftUI

struct Title: View {
    var title: String = "Placeholder title"
    
    var body: some View {
        ZStack {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding()
                .frame(minWidth: 100, idealWidth: 175, maxWidth: 250)
                .background(.purple)
                .cornerRadius(12)
        }
    }
}

#Preview {
    Title(title: "String")
}
