//
//  SearchManager.swift
//  MercadoLibre
//
//  Created by Lazaro Hernandez on 12/3/23.
//

import Foundation

protocol SearchManagerDelegate: BaseViewControllerDelegate {
    func didUpdateSearch(_ searchrManager: SearchManager, result: [ResultModel], paging: Paging)
}

 struct SearchManager {
    let urlSearch = "https://api.mercadolibre.com/sites/MLA/search?q="
    var delegate: SearchManagerDelegate?
    var results = [ResultModel]()
    
    func featchSearch(with search: String, offset: Int, limit: Int) {
            var urlString = "\(urlSearch)\(search)"
            if offset > 0 {
                urlString += "&offset=\(offset)"
            }
            if limit > 0 {
                urlString += "&limit=\(limit)"
            }
            
            performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        delegate?.loadingView(.show)
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.showError(error!.localizedDescription, completion: nil)
                    return
                }
                guard let data = data, error == nil else {
                    self.delegate?.showError(error!.localizedDescription, completion: nil)
                    return
                }
                do {
                    defer {
                        delegate?.loadingView(.hide)
                    }
                    let itemsResponse = try JSONDecoder().decode(ResultSearchData.self, from: data)
                    self.delegate?.didUpdateSearch(self, result: itemsResponse.results, paging: itemsResponse.paging)
                }
                catch {
                    self.delegate?.showError(error.localizedDescription, completion: nil)
                }
            }
            
            task.resume()
        }
        
    }
}


