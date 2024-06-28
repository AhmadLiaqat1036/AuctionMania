//
//  FillerViewForHiddenCollection.swift
//  AuctionMania
//
//  Created by usear on 6/28/24.
//

import UIKit

class FillerViewForHiddenCollection: UIView {

    @IBOutlet weak var Background: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    func viewInit(){
        let xibView = Bundle.main.loadNibNamed("FillerViewForHiddenCollection", owner: self, options: nil)![0] as! UIView
        addSubview(xibView)
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
