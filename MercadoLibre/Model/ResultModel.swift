//
//  Result.swift
//  MercadoLibre
//
//  Created by Lazaro Hernandez on 12/3/23.
//

import Foundation

struct ResultModel: Codable {
    let id: String
    let thumbnail: String
    let title: String
    let price: Double
    let installments: Installments?
}

struct Installments: Codable {
    let quantity: Int
    let amount: Double
}
