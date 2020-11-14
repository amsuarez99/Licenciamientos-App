//
//  Cuestionario.swift
//  Cuestionario
//
//  Created by Marcelo Suárez on 12/11/20.
//

import UIKit

class Cuestionario: NSObject, Codable {
    @objc private var tema: String!
    @objc private var descripcion: String!
    @objc private var foto: String!
    @objc private var preguntas: [Pregunta]!
    @objc private var test: Int
    
    override init(){
        self.tema = ""
        self.descripcion = ""
        self.foto = ""
        self.preguntas = []
        self.test = 0
    }
    
    init(tema: String, descripcion: String, foto: String, preguntas: [Pregunta]){
        self.tema = tema
        self.descripcion = descripcion
        self.foto = foto
        self.preguntas = preguntas
        self.test = 10
    }
    
    enum CodingKeys: String, CodingKey {
        case tema
        case descripcion
        case foto
        case preguntas
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tema = try container.decode(String.self, forKey: .tema)
        self.descripcion = try container.decode(String.self, forKey: .descripcion)
        self.foto = try container.decode(String.self, forKey: .foto)
        self.preguntas = try container.decode([Pregunta].self, forKey: .preguntas)
        self.test = 100
    }
    
    
    func getPreguntas()-> [Pregunta]! { return self.preguntas }
    func getPregunta(for indice: Int) -> Pregunta! { return self.preguntas[indice] }
    func getTema() -> String { return self.tema }
    func getDescripcion() -> String { return self.descripcion}
}
