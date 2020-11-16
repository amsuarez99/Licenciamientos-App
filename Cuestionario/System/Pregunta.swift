//
//  Pregunta.swift
//  CeldasPersonalizadas
//
//  Created by user180523 on 10/31/20.
//

import UIKit

class Pregunta: Codable {
    private var pregunta: String
    private var opciones: [String]
    private var indiceRespuesta: Int
    private var opcionSeleccionada: Int?
    private var feedback: String
    
    enum CodingKeys: CodingKey {
        case pregunta
        case opciones
        case indiceRespuesta
        case opcionSeleccionada
        case feedback
    }
    
    func esRespuestaCorrecta(indiceRespuesta: Int) -> Bool {
        return indiceRespuesta == self.indiceRespuesta
    }
    
    func getPregunta() -> String { return self.pregunta }
    func getOpciones() -> [String] { return self.opciones }
    func getOpcion(at index: Int) -> String { return self.opciones[index] }
    func setOpcionSeleccionada(_ ans: Int) -> Void { self.indiceRespuesta = ans }
    func getFeedback() -> String { return self.feedback }
}

