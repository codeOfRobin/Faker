// Array.swift
//
// Copyright (c) 2014–2015 Apostle (http://apostle.nl)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public extension Array {
    /**
        Shuffle the array in-place using the Fisher-Yates algorithm.
     */
    // via http://stackoverflow.com/a/24029847/511287
    public mutating func shuffle() {
        let c = count
        guard c > 1 else { return }

        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
    
    /**
        Return a shuffled version of the array using the Fisher-Yates
        algorithm.
    
        - returns: Returns a shuffled version of the array.
     */
    // via http://stackoverflow.com/a/24029847/511287
    public func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
    
    /**
        Return a random element from the array.

        - returns: Returns a random element from the array or `nil` if the
                   array is empty.
    */
    public func random() -> Element? {
        let index = Int(arc4random_uniform(UInt32(count)))
        return (count > 0) ? self[index] : nil
    }
    
    /**
        Return a random subset of `cnt` elements from the array.

        - returns: Returns a random subset of `cnt` elements from the array.
    */
    public func random(_ cnt : Int = 1) -> [Element] {
        let result = shuffled()
        
        return (cnt > result.count) ? result : Array(result[0..<cnt])
    }
}
