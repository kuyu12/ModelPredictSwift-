//
//  Stroke.swift
//  TouchDraw
//
//  Created by Christian Paul Dehli on 9/4/16.
//  With https://github.com/dehli/TouchDraw

import Foundation
import UIKit

/// A drawing stroke
open class Stroke: NSObject {
    
    /// The points that make up the stroke
    internal var points: [CGPoint]
    
    /// The properties of the stroke
    internal var settings: StrokeSettings
    
    /// Default initializer
    override public init() {
        points = []
        settings = StrokeSettings()
        super.init()
    }
    
    /// Initialize a stroke with certain points and settings
    public convenience init(points: [CGPoint], settings: StrokeSettings) {
        self.init()
        self.points = points
        self.settings = StrokeSettings(settings)
    }
    
    /// Used to decode a Stroke with a decoder
    required public convenience init?(coder aDecoder: NSCoder) {
        var points = aDecoder.decodeObject(forKey: Stroke.pointsKey) as? [CGPoint]
        if points == nil {
            points = []
        }
        
        var settings = aDecoder.decodeObject(forKey: Stroke.settingsKey) as? StrokeSettings
        if settings == nil {
            settings = StrokeSettings()
        }
        
        self.init(points: points!, settings: settings!)
    }
}

// MARK: - NSCoding
extension Stroke: NSCoding {
    internal static let pointsKey = "points"
    internal static let settingsKey = "settings"
    
    /// Used to encode a Stroke with a coder
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.points, forKey: Stroke.pointsKey)
        aCoder.encode(self.settings, forKey: Stroke.settingsKey)
    }
}


//
//  StrokeSettings.swift
//  TouchDraw
//
//  Created by Christian Paul Dehli on 9/4/16.
//
/// Properties to describe a stroke (color, width)
open class StrokeSettings: NSObject {
    
    /// Color of the brush
    private static let defaultColor = CIColor(color: UIColor.black)
    internal var color: CIColor?
    
    /// Width of the brush
    private static let defaultWidth = CGFloat(10.0)
    internal var width: CGFloat
    
    /// Default initializer
    override public init() {
        color = StrokeSettings.defaultColor
        width = StrokeSettings.defaultWidth
        super.init()
    }
    
    /// Initializes a StrokeSettings with another StrokeSettings object
    public convenience init(_ settings: StrokeSettings) {
        self.init()
        self.color = settings.color
        self.width = settings.width
    }
    
    /// Initializes a StrokeSettings with a color and width
    public convenience init(color: CIColor?, width: CGFloat) {
        self.init()
        self.color = color
        self.width = width
    }
    
    /// Used to decode a StrokeSettings with a decoder
    required public convenience init?(coder aDecoder: NSCoder) {
        let color = aDecoder.decodeObject(forKey: StrokeSettings.colorKey) as? CIColor
        var width = aDecoder.decodeObject(forKey: StrokeSettings.widthKey) as? CGFloat
        if width == nil {
            width = StrokeSettings.defaultWidth
        }
        
        self.init(color: color, width: width!)
    }
}

// MARK: - NSCoding
extension StrokeSettings: NSCoding {
    internal static let colorKey = "color"
    internal static let widthKey = "width"
    
    /// Used to encode a StrokeSettings with a coder
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.color, forKey: StrokeSettings.colorKey)
        aCoder.encode(self.width, forKey: StrokeSettings.widthKey)
    }
}

