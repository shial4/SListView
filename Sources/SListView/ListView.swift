//
//  ListView.swift
//  Calendar
//
//  Created by Shial on 21/2/18.
//  Copyright © 2018 shial. All rights reserved.
//

import Foundation
import UIKit

enum ListViewSwipeDirection {
    case top
    case right
    case bottom
    case left
}

/// The scroll direction of the list.
///
/// - horizontal: horizontal scroll
/// - vertical: vertical scroll
public enum ListViewScrollDirection {
    case horizontal
    case vertical
}

/// A view that presents data using items arranged in a single horizontal or vertical line.
open class ListView: UIView, UIGestureRecognizerDelegate {
    /// The object that acts as the delegate of the list view.
    public weak var delegate: ListViewDelegate?
    /// The object that acts as the data source of the list view.
    public weak var datasource: ListViewDatasource?
    
    /// Specifies the default margin for items of the list view.
    public var marginForItem: UIEdgeInsets = .zero
    /// The scroll direction of the list.
    public var scrollDirection: ListViewScrollDirection = .horizontal
    /// A Boolean value that determines whether scrolling is enabled.
    public var isScrollEnabled: Bool = true
    /// A integer value that determines scroll offset of a list. Every item scroll changes this value. Move a list to the left or top deacreses value. Other directions, right, bottom increases it.
    @objc public private(set) var scrollOffset: Int = 0
    
    private var CellType: ListViewCell.Type = ListViewCell.self
    private var itemsCount: Int = 0
    private var currentDisplay: Int = 0
    private var itemSize: CGSize = .zero
    private var touchBegan: TimeInterval = 0
    private var touchEnded: TimeInterval = 0
    private var shouldReloadData: Bool = true
    private lazy var itemCells: [ListViewCell] = {
        return [
            CellType.init(index: -1, frame: bounds),
            CellType.init(index: 0, frame: bounds),
            CellType.init(index: 1, frame: bounds),
        ]
    }()
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        gesture.maximumNumberOfTouches = 1
        gesture.minimumNumberOfTouches = 1
        addGestureRecognizer(gesture)
        return gesture
    }()
    private var scrollFactor: CGFloat {
        if scrollDirection == .horizontal {
            return bounds.size.width/4
        } else  {
            return bounds.size.height/4
        }
    }
    private var sizeOffset: CGFloat {
        if scrollDirection == .horizontal {
            return (marginForItem.left + marginForItem.right)
        } else  {
            return (marginForItem.top + marginForItem.bottom)
        }
    }
    private var left: ListViewCell? { return itemCells.first }
    private var current: ListViewCell? { return itemCells.count > 1 ? itemCells[1] : nil }
    private var right: ListViewCell? { return itemCells.last }
    
    deinit {
        itemCells.forEach({ $0.removeFromSuperview()})
        itemCells = []
    }
    
    open override func layoutSubviews() {
        if shouldReloadData {
            left?.itemIndex = -1
            current?.itemIndex = 0
            right?.itemIndex = 1
            itemsCount = datasource?.numberOfItems(self) ?? 0
        }
        super.layoutSubviews()
        if shouldReloadData {
            panGestureRecognizer.isEnabled = isScrollEnabled && itemsCount > 1
        }
        let size = self.bounds.size
        itemSize = CGSize(width: size.width - (marginForItem.left + marginForItem.right), height: size.height - (marginForItem.top + marginForItem.bottom))
        populateVisibleItems()
        delegate?.listView(self, didChangeDisplayItemAt: current?.itemIndex ?? 0, with: scrollOffset)
        shouldReloadData = false
    }
    
    /// Reloads the items of the list view.
    public func reloadData() {
        currentDisplay = 0
        scrollOffset = 0
        shouldReloadData = true
        self.setNeedsLayout()
    }
    
    /// Registers a class for use in creating new list cells.
    ///
    /// - Parameter classType: The class type of a cell that you want to use in the list (must be a ListViewCell subclass).
    public func registerClassForListViewCell(_ classType: ListViewCell.Type) {
        self.CellType = classType
    }
    
    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)
        switch gestureRecognizer.state {
        case .began, .changed:
            touchBegan = Date().timeIntervalSince1970
            scrollItems(scrollDirection == .horizontal ? translation.x : translation.y)
        default:
            touchEnded = Date().timeIntervalSince1970
            completeChartMovement(to: scrollDirection == .horizontal ? translation.x : translation.y)
            break
        }
    }
    
    private func populateVisibleItems() {
        itemCells.forEach({
            $0.prepareForReuse()
            let index = $0.itemIndex
            layout(for: $0, atIndex: CGFloat(index))
            $0.itemIndex = ((currentDisplay + itemsCount + $0.itemIndex) % itemsCount)
            delegate?.listView(self, willDisplay: $0, at: $0.itemIndex, with: scrollOffset + index)
            if $0.superview == nil { addSubview($0) }
        })
    }
    
    private func layout(for cell: ListViewCell, atIndex index: CGFloat) {
        if scrollDirection == .horizontal {
            cell.frame = CGRect(origin: CGPoint(x: (bounds.width * index) + marginForItem.left , y: marginForItem.top),
                                size: itemSize)
        } else {
            cell.frame = CGRect(origin: CGPoint(x: marginForItem.left, y: (bounds.height * index) + marginForItem.top),
                                size: itemSize)
        }
    }
    
    private func scrollItems(_ direction: CGFloat) {
        let leftOrigin, currentOrigin, rightOrigin: CGPoint
        if scrollDirection == .horizontal {
            leftOrigin = CGPoint(x: -bounds.width + marginForItem.left + direction, y: marginForItem.top)
            currentOrigin = CGPoint(x: marginForItem.left + direction, y: marginForItem.top)
            rightOrigin = CGPoint(x: bounds.width + marginForItem.left + direction, y: marginForItem.top)
        } else  {
            leftOrigin = CGPoint(x: marginForItem.left, y: -bounds.height + marginForItem.top + direction)
            currentOrigin = CGPoint(x: marginForItem.left, y: marginForItem.top + direction)
            rightOrigin = CGPoint(x: marginForItem.left, y: bounds.height + marginForItem.top + direction)
        }
        UIView.animate(withDuration: 0.2, delay: 0,
                       options: [.beginFromCurrentState, .curveEaseOut],
                       animations: {
                        self.left?.frame.origin = leftOrigin
                        self.current?.frame.origin = currentOrigin
                        self.right?.frame.origin = rightOrigin
        })
    }
    
    private func completeChartMovement(to direction: CGFloat) {
        func move(_ move: ListViewSwipeDirection) {
            switch move {
            case .right, .bottom:
                let cell = itemCells.removeLast()
                cell.prepareForReuse()
                let index = (left?.itemIndex ?? 0) - 1
                cell.isHidden = true
                cell.frame.origin = scrollDirection == .horizontal ? CGPoint(x: -bounds.width + marginForItem.left, y: marginForItem.top) : CGPoint(x: marginForItem.left, y: -bounds.height + marginForItem.top)
                itemCells.insert(cell, at: itemCells.startIndex)
                cell.itemIndex = index >= 0 ? index : (itemsCount - 1)
                scrollOffset -= 1
                delegate?.listView(self, willDisplay: cell, at: cell.itemIndex, with: scrollOffset - 1)
                cell.isHidden = false
            case .left, .top:
                let cell = itemCells.removeFirst()
                cell.prepareForReuse()
                let index = (right?.itemIndex ?? 0) + 1
                cell.isHidden = true
                cell.frame.origin = scrollDirection == .horizontal ? CGPoint(x: bounds.width + marginForItem.left, y: marginForItem.top) : CGPoint(x: marginForItem.left, y: bounds.height + marginForItem.top)
                itemCells.append(cell)
                cell.itemIndex = index < itemsCount ? index : 0
                scrollOffset += 1
                delegate?.listView(self, willDisplay: cell, at: cell.itemIndex, with: scrollOffset + 1)
                cell.isHidden = false
            }
            currentDisplay = current?.itemIndex ?? 0
        }
        
        let time = touchEnded - touchBegan
        switch (direction, time) {
        case (let x, _) where x > scrollFactor:
            move(scrollDirection == .horizontal ? .right : .bottom)
        case (let x, _) where x < 0 && abs(x) > scrollFactor:
            move(scrollDirection == .horizontal ? .left : .top)
        case (let x, let t) where x > 0 && t < 0.2:
            move(scrollDirection == .horizontal ? .right : .bottom)
        case (let x, let t) where x < 0  && t < 0.2:
            move(scrollDirection == .horizontal ? .left : .top)
        default:
            break
        }
        scrollItems(0)
        delegate?.listView(self, didChangeDisplayItemAt: current?.itemIndex ?? 0, with: scrollOffset)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
