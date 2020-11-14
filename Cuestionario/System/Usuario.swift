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
    @objc private var cuestionarioActual: Int
    
    override init(){
        self.respuestas = []
        self.preguntaActual = 0
        self.cuestionarioActual = 0
    }
    
    func setCuestionarioActual(_ cuestionarioActual: Int) {
        self.cuestionarioActual = cuestionarioActual
    }
    
    func setPreguntaActual(_ preguntaActual: Int) {self.preguntaActual = preguntaActual}
    func addRespuestas(_ respuesta: Int) {
        self.respuestas.append(respuesta)
        preguntaActual += 1
    }
    func contestoPregunta() {
        preguntaActual += 1
    }
    
    func getCuestionarioActual() -> Int { return self.cuestionarioActual }
    func getPreguntaActual() -> Int { return self.preguntaActual }
    func getRespuestas() -> [Int] { return self.respuestas }
}
