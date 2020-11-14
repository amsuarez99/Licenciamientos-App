//
//  DataSingleton.swift
//  Cuestionario
//
//  Created by Marcelo Suárez on 13/11/20.
//
import UIKit

class DataSingleton {
    static let shared = DataSingleton()
    
    var cuestionarios: [Cuestionario]!
    var usuario: Usuario!
    var preguntaActual: Int!
    var cuestionarioActual: Int!
    
    private init() {
        print("Singleton initialized")
        setupUser()
        extractData()
    }
    
    private func setupUser() {
        usuario = Usuario()
    }
    
    private func extractData(){
        if let path = Bundle.main.path(forResource: "cuestionarios", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.cuestionarios = try? JSONDecoder().decode([Cuestionario].self, from: data)
            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }
    
    /**
                GetCuestionario(indice)
     Regresa un cuestionario        let cuestionario = DataSingleton.shared.getCuestionario(indice: indexPath.row) dado un índice
     */
    func getCuestionario(_ indice: Int) -> Cuestionario {
        return self.cuestionarios[indice]
    }

    func getUsuario() -> Usuario {
        return usuario
    }
}
