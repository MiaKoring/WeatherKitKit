//
//  File.swift
//  
//
//  Created by Mia Koring on 22.07.24.
//

import Foundation

public extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
