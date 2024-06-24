//
//  SmallTableCellTableViewCell.swift
//  AuctionMania
//
//  Created by usear on 6/24/24.
//

import UIKit

class SmallTableCell: UITableViewCell {

   
    @IBOutlet weak var firstCell: SmallTableCellView!
    @IBOutlet weak var secondCell: SmallTableCellView!
    override func awakeFromNib() {
        super.awakeFromNib()
        firstCell.contentMode = .scaleAspectFit
        secondCell.contentMode = .scaleAspectFit
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
