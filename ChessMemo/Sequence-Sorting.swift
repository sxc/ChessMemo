//
//  Sequence-Sorting.swift
//  ChessMemo
//
//  Created by Xiaochun Shen on 2021/6/3.
//

import Foundation

extension Sequence {
    func sorted<Value>(by keyPath: PartialKeyPath<Element>, using areInIncreaingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            
            guard let value1 = $0[keyPath: keyPath] as? Value else { return false }
            guard let value2 = $1[keyPath: keyPath] as? Value else { return false }
            
            return try areInIncreaingOrder(value1, value2)
        }
}
    
    
    
    func sorted<Value: Comparable>(by keyPath: PartialKeyPath<Element>, as: Value.Type) -> [Element] {
//        self.sorted {
//            $0[keyPath: keyPath] <  $1[keyPath: keyPath]
//        }
        let function: (Value, Value) -> Bool = (<)
        return self.sorted(by: keyPath, using: function)
    }
}
