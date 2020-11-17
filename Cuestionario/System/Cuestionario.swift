//
//  Cuestionario.swift
//  Cuestionario
//
//  Created by Marcelo Suárez on 12/11/20.
//

import UIKit

//
//    func getPreguntas()-> [Pregunta]! { return self.preguntas }
//    func getPregunta(for indice: Int) -> Pregunta! { return self.preguntas[indice] }
//    func getTema() -> String { return self.tema }
//    func getDescripcion() -> String { return self.descripcion}
//}

class Cuestionario: Decodable {
    private var tema: String
    private var preguntaActual: Int?
    private var puntaje: Int?
    private var feedbackAcum: [String]?
    private var empezado: Bool = false
    
    
    var preguntas: [Pregunta]
    var leccion: Leccion
    var historietas: [Historieta]
    
    private var terminado: Bool {
        return preguntaActual == preguntas.count
    }
    private var progreso: Int? {
        guard let preguntaActual = self.preguntaActual else { return nil }
        return Int( preguntaActual / preguntas.count ) * 100
    }
    
    private var calificacion: Double? {
        guard let puntaje = self.puntaje else { return nil }
        return Double( puntaje / preguntas.count )
    }
    
    private var isDisponible: Bool = false
    
    enum CodingKeys: CodingKey {
        case tema
        case preguntaActual
        case puntaje
        case feedbackAcum
        case preguntas
        case leccion
        case historietas
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tema = try container.decode(String.self, forKey: .tema)
        self.preguntaActual = try container.decodeIfPresent(Int.self, forKey: .preguntaActual)
        self.puntaje = try container.decodeIfPresent(Int.self, forKey: .puntaje)
        self.feedbackAcum = try container.decodeIfPresent([String].self, forKey: .feedbackAcum)
        self.preguntas = try container.decode([Pregunta].self, forKey: .preguntas)
        self.leccion = try container.decode(Leccion.self, forKey: .leccion)
        self.historietas = try container.decode([Historieta].self, forKey: .historietas)
    }
    
    func getNumPreguntaActual() -> Int? {
        guard let preguntaActual = self.preguntaActual else { return nil }
        return preguntaActual
    }
    
    func getNumPreguntas() -> Int { return self.preguntas.count }
    func getPreguntaActual() -> Pregunta {return self.preguntas[self.preguntaActual!]}
    func getHistorietas() -> [Historieta] { return self.historietas }
    func getTema() -> String { return self.tema }
    func getPuntaje() -> Int? {
        guard let puntaje = self.puntaje else { return nil }
        return puntaje
    }
    func getProgreso() -> Int? { return self.progreso }
    func getCalificacion() -> Double? {
        guard let calificacion = self.calificacion else { return nil }
        return calificacion
    }
    
    
    func startCuestionario() {
        self.preguntaActual = 0
        self.puntaje = 0
        self.feedbackAcum = []
        self.empezado = true
    }
    func contestaPregunta() -> Void { self.preguntaActual = self.preguntaActual! + 1 }
    func isTerminado() -> Bool { return self.terminado }
    func contestaCorrecto() -> Void { self.puntaje = self.puntaje! + 1 }
    func setPreguntaActual(_ preguntaActual: Int) -> Void { self.preguntaActual = preguntaActual }
}
