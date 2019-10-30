//
//  TokenReponse.swift
//  SsgSag
//
//  Created by 이혜주 on 30/10/2019.
//  Copyright © 2019 wndzlf. All rights reserved.
//

import Foundation

struct TokenResponse: Codable {
    let status: Int
    let message: String
    let data: SsgSagToken?
}

struct SsgSagToken: Codable {
    let token: String?
}

