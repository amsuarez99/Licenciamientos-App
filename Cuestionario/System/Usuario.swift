//
//  Usuario.swift
//  Cuestionario
//
//  Created by Marcelo Suárez on 12/11/20.
//

import UIKit

class Usuario: NSObject {
    @objc private var respuestas: [Int]
    @objc private var preguntaActual: Int
    
    
    override init(){
        self.respuestas = []
        self.preguntaActual = 0
    }
    
    func setPreguntaActual(_ preguntaActual: Int) {self.preguntaActual = preguntaActual}
    func addRespuestas(_ respuesta: Int) {
        self.respuestas.append(respuesta)
        preguntaActual += 1
    }
    func contestoPregunta() {
        preguntaActual += 1
    }
    func getPreguntaActual() -> Int { return self.preguntaActual }
    func getRespuestas() -> [Int] { return self.respuestas }
}
