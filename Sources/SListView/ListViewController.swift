//
//  ListViewController.swift
//  Calendar
//
//  Created by Shial on 21/2/18.
//  Copyright © 2018 shial. All rights reserved.
//

import Foundation
import UIKit

/// A view controller that specializes in managing a list view.
open class ListViewController: UIViewController, ListViewDelegate, ListViewDatasource {
    /// Returns the list view managed by the controller object.
    @objc public var listView: ListView {
        return view as! ListView
    }
    
    final override public func loadView() {
        let list = ListView()
        list.clipsToBounds = true
        list.delegate = self
        list.datasource = self
        view = list
    }
    
    /// Tells the data source to return the number of items of a list view. Default implementation return 3. As it is default value for a list to reuse cell view.
    ///
    /// - Parameter listView: The list-view object requesting this information.
    /// - Returns: The number of items.
    open func numberOfItems(_ listView: ListView) -> Int { return 3 }
    /// Tells the delegate the list view did change present display item.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    open func listView(_ listView: ListView, didChangeDisplayItemAt index: Int, with offset: Int) {}
    /// Tells the delegate the list view is about to draw a cell for a particular item. Information about list scroll offset is already changed. You can get it from a list by `scrollOffset`.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - cell: A list-view cell object that listView is going to use when drawing the row.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    open func listView(_ listView: ListView, willDisplay cell: ListViewCell, at index: Int, with offset: Int) {}
    /// Tells the delegate that a specified item is about to be selected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    open func listView(_ listView: ListView, willSelectItemAt index: Int, with offset: Int) {}
    /// Tells the delegate that a specified item is now selected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    open func listView(_ listView: ListView, didSelectItemAt index: Int, with offset: Int) {}
    /// Tells the delegate that a specified item is about to be deselected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    open func listView(_ listView: ListView, willDeselectItemAt index: Int, with offset: Int) {}
    /// Tells the delegate that a specified item is now deselected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    open func listView(_ listView: ListView, didDeselectItemAt index: Int, with offset: Int) {}
}
