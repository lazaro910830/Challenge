//
//  DetailViewController.swift
//  MercadoLibre
//
//  Created by Lazaro Hernandez on 12/3/23.
//

import UIKit
import ImageSlideshow

class DetailViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var carrouselImageView: ImageSlideshow!
    @IBOutlet weak var intallmentLabel: UILabel!
    @IBOutlet weak var warrantyLabel: UILabel!
    @IBOutlet weak var mercadoLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var soldLabel: UILabel!
    
    // MARK: - Properties
    var result: ResultModel?
    var fullResultManager = FullResultManager()
    var fullResult: FullResultModel?
    
    // MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullResultManager.delegate = self
        fullResultManager.featchItem(with: result?.id ?? "")
        
        setupView()
    }
    
    // MARK: - Private methods
    func setupView() {
        titleLabel.text = result?.title
        priceLabel.text = String(format: "$%.0f", result?.price ?? 0)
        
        if let installments = result?.installments {
            intallmentLabel.text = "\(installments.quantity) x $\(Int(installments.amount))"
        }
    }
    
    func setupFullResult() {
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = .black
        pageIndicator.pageIndicatorTintColor = .gray
        carrouselImageView.pageIndicator = pageIndicator
        
        var carrouselImages = [SDWebImageSource]()
        
        for image in fullResult?.pictures ?? [] {
            if let imageURL = URL(string: image.url ?? "") {
                carrouselImages.append(SDWebImageSource(url: imageURL, placeholder: UIImage(named: "imagePlaceholder")))
            }
        }
        carrouselImageView.setImageInputs(carrouselImages)
        
        soldLabel.text = "Vendidos: \(fullResult?.sold_quantity ?? 0)"
        availableLabel.text = "Disponibles: \(fullResult?.available_quantity ?? 0)"
        mercadoLabel.text = fullResult?.accepts_mercadopago ?? true ? "Acepta Mercado Pago" : "No acepta Mercado Pago"
        mercadoLabel.textColor = fullResult?.accepts_mercadopago ?? true ? UIColor.green : UIColor.red
        warrantyLabel.text = fullResult?.warranty
    }

}

// MARK: - Extensions
extension DetailViewController: FullResultManagerDelegate {
    func didUpdateItem(_ fullItemManager: FullResultManager, result: FullResultModel) {
        self.fullResult = result
        DispatchQueue.main.async {
            self.setupFullResult()
        }
    }
}
