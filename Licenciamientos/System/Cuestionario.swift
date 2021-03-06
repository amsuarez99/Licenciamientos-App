//
//  Cuestionario.swift
//  Cuestionario
//
//  Created by Marcelo Suárez on 12/11/20.
//

import UIKit

class Cuestionario: Codable {
    private var tema: String
    private var foto: String
    private var preguntaActual: Int?
    private var puntaje: Int?
    private var feedbackAcum: [String]?
    private var disponible: Bool?
    private var calificacion: Int?
    
    var preguntas: [Pregunta]
    var leccion: Leccion
    var historietas: [Historieta]
    
    private var progreso: Int? {
        guard let preguntaActual = self.preguntaActual else { return nil }
        return Int( preguntaActual / preguntas.count ) * 100
    }
    

    
    enum CodingKeys: CodingKey {
        case tema
        case disponible
        case preguntaActual
        case puntaje
        case calificacion
        case feedbackAcum
        case preguntas
        case leccion
        case historietas
        case foto
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tema = try container.decode(String.self, forKey: .tema)
        self.foto = try container.decode(String.self, forKey: .foto)
        self.disponible = try container.decode(Bool.self, forKey: .disponible)
        self.preguntaActual = try container.decodeIfPresent(Int.self, forKey: .preguntaActual)
        self.calificacion = try container.decodeIfPresent(Int.self, forKey: .calificacion)
        self.puntaje = try container.decodeIfPresent(Int.self, forKey: .puntaje)
        self.feedbackAcum = try container.decodeIfPresent([String].self, forKey: .feedbackAcum)
        self.preguntas = try container.decode([Pregunta].self, forKey: .preguntas)
        self.leccion = try container.decode(Leccion.self, forKey: .leccion)
        self.historietas = try container.decode([Historieta].self, forKey: .historietas)
    }
    

    func getNumPreguntas() -> Int { return self.preguntas.count }
    func getPreguntaActual() -> Pregunta {return self.preguntas[self.preguntaActual!]}
    func getHistorietas() -> [Historieta] { return self.historietas }
    func getTema() -> String { return self.tema }
    func getProgreso() -> Int? { return self.progreso }
    func getLeccion() -> Leccion { return self.leccion }
    func getFeedback() -> [String] { return self.feedbackAcum! }
    func getFoto() -> String { return self.foto }
    func getPuntaje() -> Int? {
        guard let puntaje = self.puntaje else { return nil }
        return puntaje
    }
    
    func calificaCuestionario() -> Void {
        self.calificacion = Int(Double(self.puntaje!) / Double(self.preguntas.count) * 100)
    }
    
    func getCalificacion() -> Int? {
        guard let calificacion = self.calificacion else { return nil }
        return calificacion
    }
    func getNumPreguntaActual() -> Int? {
        guard let preguntaActual = self.preguntaActual else { return nil }
        return preguntaActual
    }
    
    
    func agregaFeedback(_ fb: String) -> Void {
        self.feedbackAcum?.append(fb)
    }
    
    func isDisponible() -> Bool {
        return self.disponible!
    }
    
    func isDisponible(_ b: Bool) -> Void {
        self.disponible = b
    }
    
    func isTerminado() -> Bool { return self.preguntaActual == self.preguntas.count }
    
    func startCuestionario() -> Void {
        self.preguntaActual = 0
        self.puntaje = 0
        self.feedbackAcum = []
        self.disponible = true
    }
    func contestaPregunta() -> Void { self.preguntaActual = self.preguntaActual! + 1 }
    func contestaCorrecto() -> Void { self.puntaje = self.puntaje! + 1 }
    func setPreguntaActual(_ preguntaActual: Int) -> Void { self.preguntaActual = preguntaActual }
}
