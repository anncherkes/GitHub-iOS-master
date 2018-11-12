//
//  RepositoryDetailTableViewCell.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/12/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit
import SDWebImage
class RepositoryDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerImageView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loginName: UILabel!
    
    private var placeholder: UIImage? = UIImage(named: "placeholder")

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    public func setup(with fork: ForkDTO) {
        
        loginName.text = fork.ownerLogin
        
        guard let path = fork.ownerAvatarURL else {
            self.avatarImageView.image = placeholder
            return
        }
        
        let url = URL(string: path)
        self.avatarImageView.sd_setImage(with: url, placeholderImage: placeholder, options: SDWebImageOptions.continueInBackground) { (image, error, cache, url) in
            if error == nil {
                self.avatarImageView.image = image
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupUI() {
        containerView.layer.cornerRadius = 10.0
        containerImageView.layer.cornerRadius = 45.0
        containerImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 43.0
        avatarImageView.layer.masksToBounds = true
    }
}
