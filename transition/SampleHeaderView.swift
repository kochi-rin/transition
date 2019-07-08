//
//  SampleHeaderView.swift
//  transition
//
//  Created by kouchi.rin on 2019/07/08.
//  Copyright © 2019 kouchi.rin. All rights reserved.
//

import UIKit

class SampleHeaderView: UIView {

    @IBOutlet weak var closeButton: UIButton!

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    private func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            addSubview(view)
            view.frame = bounds
        }
    }

    typealias DidTapButton = (UIButton) -> Void
    var didTouchUpInside: DidTapButton?

    @IBAction func tappedClose(_ sender: Any) {
        didTouchUpInside?(sender as! UIButton)
    }
}
