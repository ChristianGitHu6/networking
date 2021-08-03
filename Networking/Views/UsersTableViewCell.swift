//
//  PostTableViewCell.swift
//  Networking
//
//  Created by Anna on 8/1/21.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    static let identifier = "UsersTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtTitleLabel: UILabel!
    @IBOutlet weak var logoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: UserData) {
        titleLabel.text = "\(data.first_name) \(data.last_name)"
        subtTitleLabel.text = data.email
        
        if let url = URL(string: data.avatar) {
            logoView.load(url: url)
        }
    }
}
