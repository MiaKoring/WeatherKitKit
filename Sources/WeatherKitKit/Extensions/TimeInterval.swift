//
//  File.swift
//  
//
//  Created by Mia Koring on 22.07.24.
//

import Foundation
import SwiftChameleon

public extension TimeInterval {
    var roundedHours: Int {
        Double(self.float / 3600.0).roundedInt
    }
}
