import Foundation

// MARK: - Ordered Array utils
public extension Array where Element: Comparable {
    
    func binSearchFirstIndex(greaterThanOrEqualTo value: Element) -> Int? {
        return binSearchFirstIndex(greaterThanOrEqualTo: value, keyPath: \.self)
    }
    
    func binSearchFirstIndex<Value>(greaterThanOrEqualTo value: Value, keyPath: KeyPath<Element, Value>) -> Int? where Value: Comparable {
        return self[startIndex..<endIndex].binSearchFirstIndex(greaterThanOrEqualTo: value, keyPath: keyPath)
    }
}

public extension ArraySlice where Element: Comparable {
    
    func binSearchFirstIndex(greaterThanOrEqualTo value: Element) -> Int? {
        return binSearchFirstIndex(greaterThanOrEqualTo: value, keyPath: \.self)
    }
    func binSearchFirstIndex<Value>(greaterThanOrEqualTo value: Value, keyPath: KeyPath<Element, Value>) -> Int? where Value: Comparable {
        guard startIndex < endIndex else {
            return nil
        }
        let span = endIndex - startIndex
        let midpoint = startIndex + span / 2
        let midpointValue = self[midpoint][keyPath: keyPath]
        
        if midpointValue == value {
            return midpoint
        } else if midpointValue > value {
            guard midpoint > startIndex else { return midpoint }
            return self[startIndex..<midpoint].binSearchFirstIndex(greaterThanOrEqualTo: value, keyPath: keyPath)
        }
        
        guard endIndex > midpoint + 1 else { return nil }
        return self[midpoint + 1..<endIndex].binSearchFirstIndex(greaterThanOrEqualTo: value, keyPath: keyPath)
        
    }
}
