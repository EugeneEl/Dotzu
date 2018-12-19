//
//  RequestHeadersTableViewCell.swift
//  exampleWindow
//
//  Created by Remi Robert on 25/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

protocol RequestHeadersTableViewCellInteracting: class {
    func shareDidTapInCell(_ cell: RequestHeadersTableViewCell)
}

class RequestHeadersTableViewCell: UITableViewCell, LogCellProtocol {

    // MARK: - Outlets
    
    @IBOutlet weak var textview: UITextView!

    // MARK: - Vars
    
    weak var delegate: RequestHeadersTableViewCellInteracting?
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textview.isUserInteractionEnabled = false
    }
    
    // MARK: - Actions
    
    @IBAction fileprivate func shareDidTap() {
        delegate?.shareDidTapInCell(self)
    }
    
    // MARK: - Public

    func configure(log: LogProtocol) {
        guard let log = log as? LogRequest else {return}
        textview.text = nil
        guard let headers = log.headers else {return}

        let string = NSMutableString()
        string.append("[\n")
        for (key, value) in headers {
            string.append("  \(key) : \(value)\n")
        }
        string.append("]")
        textview.text = string as String
    }
}
