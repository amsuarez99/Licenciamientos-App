//
//  Usuario.swift
//  Cuestionario
//
//  Created by Marcelo Suárez on 12/11/20.
//

import UIKit

class Usuario: NSObject {
    @objc var cuestionarioActual: Int
    
    override init(){
        self.cuestionarioActual = 0
    }
    
    func setCuestionarioActual(_ cuestionarioActual: Int) {
        self.cuestionarioActual = cuestionarioActual
    }

    func getCuestionarioActual() -> Int { return self.cuestionarioActual }
}
