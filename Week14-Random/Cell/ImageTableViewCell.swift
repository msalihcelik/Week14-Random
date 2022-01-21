//
//  ImageTableViewCell.swift
//  Week14-Random
//
//  Created by Mehmet Salih ÇELİK on 21.01.2022.
//

import UIKit
import MobilliumBuilders

class ImageTableViewCell: UITableViewCell {

    let customImageView = UIImageViewBuilder().build()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func addSubViews() {
        customImageView.edgesToSuperview(excluding: .bottom)
        customImageView.bottomToSuperview().constant = -5
    }

}
