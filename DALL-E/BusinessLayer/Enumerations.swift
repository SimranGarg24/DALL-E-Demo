//
//  Enumerations.swift
//  DALL-E
//
//  Created by Saheem Hussain on 06/10/23.
//

import Foundation

enum Style: String {
    case noStyle = "No Style"
    case oilPaint = "Oil painting"
    case waterColor = "Water color"
    case sketch = "Sketch"
    case ink = "Ink"
    case hyperRealistic = "Hyper-Realistic"
    case cartoon = "Cartoon"
    case abstract = "Abstract"
    case anime = "Anime"
    case logo = "Logo"
    case retro = "Retro"
    case haunted = "Haunted"
    case illustration = "Illustration"
    case threeD = "3-Dimensional"
    case popArt = "Pop Art"
}

enum Resolution: String, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
