//
//  ImSh_UITableView.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/20/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// To deselect all rows
    ///
    /// - Parameter animated: Boolean
    public func deselectAllRows(animated: Bool = false) {
        for indexPath in self.indexPathsForSelectedRows ?? [] {
            self.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    /// Shakes the cell at defined indexPath
    ///
    /// - Parameter atIndexP: IndexPath
    public func shake(atIndexP: IndexPath) {
        if let cell = self.cellForRow(at: atIndexP) {
            cell.shake()
        }
    }
    
    /// To reload sections
    ///
    /// - Parameter withAnimation: UITableView.RowAnimation
    public func reloadSections(withAnimation: UITableView.RowAnimation) {
        self.reloadData()
        let sections = self.numberOfSections
        if sections == 0 { return }
        let idxSet = IndexSet(integersIn: 0...sections - 1)
        self.reloadSections(idxSet, with: withAnimation)
    }
    
   
    
}

