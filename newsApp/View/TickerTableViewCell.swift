//
//  TickerTableViewCell.swift
//  newsApp
//
//  Created by Thaddeus Lorenz on 10/18/21.
//

import Foundation
import UIKit

// Ticker cell UI elements using UIKIT
// I used UIKit for the Ticker cells because the cells were simple in terms of visualizing data
// For more complicated cells (i.e., News Cells) I programmatically set constraints and UI elements

class TickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coinNameLabel: UILabel!
    
    @IBOutlet weak var coinValueLabel: UILabel!
    
}



