//
//  ListViewCell.swift
//  Calendar
//
//  Created by Shial on 21/2/18.
//  Copyright © 2018 shial. All rights reserved.
//

import Foundation
import UIKit

/// A cell in a list view.
open class ListViewCell: UIView {
    /// Initializes a list cell with a index and returns it to the caller.
    ///
    /// - Parameters:
    ///   - index: A integer value used to identify the cell object item.
    ///   - frame: The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
    required public init(index: Int, frame: CGRect) {
        itemIndex = index
        super.init(frame: frame)
        setupCell()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }
    /// An Integer value that indicates the cell's item index.
    var itemIndex: Int = 0
    /// A Boolean value that indicates whether the cell is selected.
    public var isSelected: Bool = false
    /// Prepares a reusable cell for reuse by the list view's delegate.
    open func prepareForReuse() {}
    
    /// Prepares a cell for the first time by the list after initialize. Called only once per cell lifetime. You usually override this method to perform additional initialization on views loaded from nib files.
    open func setupCell() {}
}
