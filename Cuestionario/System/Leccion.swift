//
//  Leccion.swift
//  Cuestionario
//
//  Created by Marcelo Suárez on 14/11/20.
//

import UIKit

class Leccion: Codable {
    private var conceptosClave: [String]
    private var texto: String
    
    enum CodingKeys: CodingKey {
        case conceptosClave
        case texto
    }
}
