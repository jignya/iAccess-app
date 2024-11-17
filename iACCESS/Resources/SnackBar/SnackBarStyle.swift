//
//  SnackBarStyle.swift
//  CommonUI
//
//  Created by Ahmad Almasri on 9/11/20.
//

import Foundation
import UIKit


public struct SnackBarStyle {
	public init() { }
	// Container
    public var background: UIColor = UIColor(named: "asterisk") ?? .red
	var padding = 0
	var inViewPadding = 20
	// Label
    public var textColor: UIColor = UIColor.white
    public var font: UIFont = UIFont.roboto(size: 14, weight: .Medium)!
	var maxNumberOfLines: UInt = 2
	// Action
	public var actionTextColorAlpha: CGFloat = 0.5
	public var actionFont: UIFont = UIFont.systemFont(ofSize: 17)
	public var actionTextColor: UIColor = .red
}
