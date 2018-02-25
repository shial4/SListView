//
//  ListViewDatasource.swift
//  Calendar
//
//  Created by Shial on 21/2/18.
//  Copyright © 2018 shial. All rights reserved.
//

import Foundation
import UIKit

/// The ListViewDatasource protocol is adopted by an object that mediates the application’s data model for a SListView object. The data source provides the list-view object with the information it needs to construct and modify a list view.
public protocol ListViewDatasource: class {
    /// Tells the data source to return the number of items of a list view.
    ///
    /// - Parameter listView: The list-view object requesting this information.
    /// - Returns: The number of items.
    func numberOfItems(_ listView: ListView) -> Int
}

extension ListViewDatasource {
    /// Tells the data source to return the number of items of a list view. Default implementation return 3. As it is default value for a list to reuse cell view.
    ///
    /// - Parameter listView: The list-view object requesting this information.
    /// - Returns: The number of items.
    public func numberOfItems(_ listView: ListView) -> Int { return 3 }
}
