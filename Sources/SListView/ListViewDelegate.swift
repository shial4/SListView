//
//  ListViewDelegate.swift
//  Calendar
//
//  Created by Shial on 21/2/18.
//  Copyright © 2018 shial. All rights reserved.
//

import Foundation

/// The delegate of a SListView object must adopt the ListViewDelegate protocol. Optional methods of the protocol allow the delegate to manage selections, configure and perform other actions.
public protocol ListViewDelegate: class {
    /// Tells the delegate the list view did change present display item.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    func listView(_ listView: ListView, didChangeDisplayItemAt index: Int, with offset: Int)
    /// Tells the delegate the list view is about to draw a cell for a particular item.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - cell: A list-view cell object that listView is going to use when drawing the row.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    func listView(_ listView: ListView, willDisplay cell: ListViewCell, at index: Int, with offset: Int)
    /// Tells the delegate that a specified item is about to be selected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    func listView(_ listView: ListView, willSelectItemAt index: Int, with offset: Int)
    /// Tells the delegate that a specified item is now selected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    func listView(_ listView: ListView, didSelectItemAt index: Int, with offset: Int)
    /// Tells the delegate that a specified item is about to be deselected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    func listView(_ listView: ListView, willDeselectItemAt index: Int, with offset: Int)
    /// Tells the delegate that a specified item is now deselected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    func listView(_ listView: ListView, didDeselectItemAt index: Int, with offset: Int)
}

extension ListViewDelegate {
    /// Tells the delegate the list view did change present display item.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    public func listView(_ listView: ListView, didChangeDisplayItemAt index: Int, with offset: Int) {}
    /// Tells the delegate the list view is about to draw a cell for a particular item.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - cell: A list-view cell object that listView is going to use when drawing the row.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    public func listView(_ listView: ListView, willDisplay cell: ListViewCell, at index: Int, with offset: Int) {}
    /// Tells the delegate that a specified item is about to be selected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    public func listView(_ listView: ListView, willSelectItemAt index: Int, with offset: Int) {}
    /// Tells the delegate that a specified item is now selected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    public func listView(_ listView: ListView, didSelectItemAt index: Int, with offset: Int) {}
    /// Tells the delegate that a specified item is about to be deselected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    public func listView(_ listView: ListView, willDeselectItemAt index: Int, with offset: Int) {}
    /// Tells the delegate that a specified item is now deselected.
    ///
    /// - Parameters:
    ///   - listView: The list-view object informing the delegate of this impending event.
    ///   - index: An index locating the item in listView.
    ///   - offset:  A integer value that determines scroll offset of a list for given item.
    public func listView(_ listView: ListView, didDeselectItemAt index: Int, with offset: Int) {}
}
