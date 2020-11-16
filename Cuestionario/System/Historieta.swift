//
//  Historieta.swift
//  Cuestionario
//
//  Created by user180523 on 11/4/20.
//
import Foundation

class Historieta: Codable {
    private var foto : String
    private var titulo : String
    private var explicacion : String
    
    enum CodingKeys: CodingKey {
        case foto
        case titulo
        case explicacion
    }
    
    func getTitulo() -> String { return self.titulo }
    func getExplicacion() -> String { return self.explicacion }
}
