//
//  ResultSearchData.swift
//  MercadoLibre
//
//  Created by Lazaro Hernandez on 12/3/23.
//

import Foundation

struct ResultSearchData: Codable {
    let results: [ResultModel]
    let paging: Paging
}

struct Paging: Codable {
    let total: Int
}

