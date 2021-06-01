//
//  Binding-OnChange.swift
//  ChessMemo
//
//  Created by Xiaochun Shen on 2021/6/1.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue},
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
