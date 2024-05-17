
//  GlassesType.swift
//  Glass-Fit

import Foundation

enum GlassesType: String, CaseIterable, CustomStringConvertible {
    case wayfare
    case geometric
    case aviator
    case browline
    case cateye
    case rectangle
    case round
    case square
    case oval
    
    var description: String {
        self.rawValue.capitalized
    }
}
