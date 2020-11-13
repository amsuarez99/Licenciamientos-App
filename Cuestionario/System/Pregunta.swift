//
//  Pregunta.swift
//  CeldasPersonalizadas
//
//  Created by user180523 on 10/31/20.
//

import UIKit

class Pregunta: NSObject, Codable{
    
    var pregunta : String!
    var opciones : [String]!
    var indiceRespuesta : Int!
    
    override init(){
        self.pregunta = "Ninguna"
        self.opciones = []
        self.indiceRespuesta = nil
    }
    
    init(pregunta: String, opciones: [String], indiceRespuesta: Int){
        self.pregunta = pregunta
        self.opciones = opciones
        self.indiceRespuesta = indiceRespuesta
    }
    
    func getPregunta() -> String! { return self.pregunta }
    func getOpciones() -> [String]! { return self.opciones }
    func getIndiceRespuesta() -> Int! { return self.indiceRespuesta }
    func getOpcion(for indice: Int) -> String { return self.opciones[indice] }
}
