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
    
    private init() {
        print("Singleton initialized")
        setupUser()
        fetchData()
    }
    
    private func setupUser() {
        usuario = Usuario()
    }
    
    private func fetchData(){
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.decode(data)
            } catch { print("Unexpected error fetching data: \(error).") }
        }
    }
    
    private func decode(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            self.cuestionarios = try decoder.decode([Cuestionario].self, from: data)
        } catch { print("Unexpected error decoding data: \(error).") }
    }
}
