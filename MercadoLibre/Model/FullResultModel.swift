//
//  FullResult.swift
//  MercadoLibre
//
//  Created by Lazaro Hernandez on 12/3/23.
//

import Foundation

struct FullResultModel: Decodable {
    let pictures: [Images]?
    let sold_quantity: Int
    let available_quantity: Int
    let accepts_mercadopago: Bool
    let warranty: String
}

struct Images: Decodable {
    let url: String?
}


