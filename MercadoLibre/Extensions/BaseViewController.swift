//
//  BaseViewController.swift
//  MercadoLibre
//
//  Created by Lazaro Hernandez on 12/3/23.
//

import UIKit

enum LoadingViewState {
    case show
    case hide
}

protocol BaseViewControllerDelegate {
    func loadingView(_ state: LoadingViewState)
    func showError(_ error: String, completion: (()->Void)?)
}

class BaseViewController: UIViewController {
    
    var loadingIndicator = UIActivityIndicatorView(style: .large)
    
    static var identifier: String {
        return String(describing: self)
    }
    
    /// Use this method in order to instantiate the view controller.
    static func instantiate(storyboardName: String) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
    
    func showError(_ error: String, completion: (()->Void)?) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            if action.style == .cancel {
                print("OK button pressed")
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func loadingView(_ state: LoadingViewState) {
        switch state {
        case .show:
            showLoading()
        case .hide:
            hideLoading()
        }
    }
    
    private func showLoading() {
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        loadingIndicator.startAnimating()
    }
    
    private func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.removeFromSuperview()
        }
    }
    
}
