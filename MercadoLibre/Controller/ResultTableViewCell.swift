//
//  ResultTableViewCell.swift
//  MercadoLibre
//
//  Created by Lazaro Hernandez on 12/3/23.
//

import UIKit
import SDWebImage

class ResultTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = String(describing: ResultTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .white
    }
    
    func setupCell(with result: ResultModel) {
        guard let imageURL = URL(string: result.thumbnail) else { return }
        
        productImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "imagePlaceholder"))
                                     
        titleLabel.text = result.title
        priceLabel.text = String(format: "$%.0f", result.price)
        
        if let installments = result.installments {
            descriptionLabel.text = "\(installments.quantity) x $\(Int(installments.amount))"
        }
    }

}
