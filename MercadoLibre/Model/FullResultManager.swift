//
//  FullResultManager.swift
//  MercadoLibre
//
//  Created by Lazaro Hernandez on 12/3/23.
//

import Foundation

protocol FullResultManagerDelegate: BaseViewController {
    func didUpdateItem(_ fullItemManager: FullResultManager, result: FullResultModel)
}

struct FullResultManager {
    let urlSearch = "https://api.mercadolibre.com/items/"
    var delegate: FullResultManagerDelegate?
    
    func featchItem(with id: String) {
        let urlString = "\(urlSearch)\(id)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        delegate?.loadingView(.show)
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.showError(error?.localizedDescription ?? "", completion: nil)
                    return
                }
                guard let data = data, error == nil else {
                    self.delegate?.showError(error?.localizedDescription ?? "", completion: nil)
                    return
                }
                do {
                    defer {
                        delegate?.loadingView(.hide)
                    }
                    let itemsResponse = try JSONDecoder().decode(FullResultModel.self, from: data)
                    self.delegate?.didUpdateItem(self, result: itemsResponse)
                }
                catch {
                    self.delegate?.showError(error.localizedDescription, completion: nil)
                }
            }
            
            task.resume()
        }
    }
}
