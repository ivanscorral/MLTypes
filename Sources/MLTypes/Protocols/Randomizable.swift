//
//  Protocols.swift
//
//
//  Created by Ivan Sanchez on 28/11/23.
//

import Foundation

public protocol Randomizable: Comparable{
    static func random(in range: ClosedRange<Self>) -> Self
}
