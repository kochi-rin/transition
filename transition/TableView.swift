//
//  TableView.swift
//  transition
//
//  Created by kouchi.rin on 2019/07/19.
//  Copyright © 2019 kouchi.rin. All rights reserved.
//

import UIKit

class TableView: UITableView {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let locationInView = gestureRecognizer.location(in: self)
        print("where are we \(locationInView.y)")
        return locationInView.y > 0
    }
}
