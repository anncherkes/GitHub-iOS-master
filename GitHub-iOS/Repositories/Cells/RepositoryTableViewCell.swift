//
//  RepositoriesTableViewCell.swift
//  iOS-GitHub
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit
import SDWebImage

public class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerImageView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    
    private var placeholder: UIImage? = UIImage(named: "placeholder")
    
    public func setup(with repository: RepositoryDTO) {
        setupUI()
        
        titleLabel.text = repository.repositoryName
        descriptionLabel.text = repository.repositoryDescription
        watchersLabel.text = repository.watchersCount.description
        forksLabel.text = repository.forksCount.description
        
        
        guard let path = repository.avatarImage else {
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
    
    private func setupUI() {
        containerView.layer.cornerRadius = 10.0
        containerImageView.layer.cornerRadius = 45.0
        containerImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 43.0
        avatarImageView.layer.masksToBounds = true
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
