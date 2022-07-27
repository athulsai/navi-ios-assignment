//
//  PullRequestCollectionViewCell.swift
//  NaviAssignment
//
//  Created by Athul Sai on 26/07/22.
//

import UIKit

class PullRequestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(with result: PullRequestsResponse) {
        titleLabel.text = result.title
        authorLabel.text = "by \(result.user?.login ?? "NA")"
        userImageView.loadImageFromURL(urlString: result.user?.avatarURL ?? nil, placeholder: UIImage(named: "user-placeholder"))
        userImageView.layer.cornerRadius = 16.0

        if let createdAt = result.createdAt, let closedAt = result.closedAt {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            let createdDate = formatter.string(from: createdAt)
            let closedDate = formatter.string(from: closedAt)
            messageLabel.text = "Created: \(createdDate), Closed: \(closedDate)"
        } else {
            messageLabel.text = ""
        }
    }
}
