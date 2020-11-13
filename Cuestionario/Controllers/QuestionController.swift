//
//  QuestionController.swift
//  Cuestionario
//
//  Created by user180523 on 11/4/20.
//

import UIKit

protocol cuestionarioController {
    func getResumenInstance() -> ResumenSwipeController
}

class QuestionController: UIViewController{
    
    private var cellHeight = 75
    var selectedAnswer: Int?
    var delegadoCuestionario: cuestionarioController!

    let pregunta = Pregunta(pregunta: "Hola", opciones: ["La salvaguarda y promoción del acervo cultural de la Nación", "Pagarle a los autores de obras literarias", "Reconocer a los autores por cada obra literaria que realice", "Todas las anteriores"], indiceRespuesta: 0)
    
    private let tableView : UITableView = {
       let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let lbProgreso: UILabel = {
        let lb = UILabel()
        lb.font = Constants.App.Fonts.textFont
        lb.textColor = Constants.App.Colors.grayTint
        lb.text = "Pregunta 1 de 10"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let lbScore: UILabel = {
        let lb = UILabel()
        lb.font = Constants.App.Fonts.textFont
        lb.textColor = Constants.App.Colors.grayTint
        lb.text = "Score: 0"
        lb.textAlignment = .right
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let tvPregunta: UITextView = {
       let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Q1: La ley Federal del Derecho de Autor tiene por objeto: ", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.markupFont, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint])
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let btnSiguiente: UIButton = {
        let btn = UIButton()
        btn.setTitle("Continuar", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = Constants.App.Colors.orangeTint
        btn.titleLabel?.font = Constants.App.Fonts.markupFont
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(contestaPregunta), for: .touchUpInside)
        return btn
    }()
    
    @IBAction private func contestaPregunta() {
        guard let i = selectedAnswer else {return}
        if i == pregunta.indiceRespuesta {
            // Feedback de respuesta correcta
        } else {
            // Feedback de respuesta incorrecta
        }
        
        // Checar con superclase en què pregunta estoy
        let qVC = QuestionController()
        qVC.lbScore.text = "hola"
        qVC.delegadoCuestionario = delegadoCuestionario
        self.navigationController?.pushViewController(qVC, animated: true)
        self.navigationController?.viewControllers.remove(at: (navigationController?.viewControllers.count)! - 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(presentVC))
//            UIBarButtonItem(title: "Resumen", style: .plain, target: self, action: #selector(presentVC))
        
        self.view.backgroundColor = .white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        setupViews()
    }
    
    @IBAction private func presentVC(){
        present(delegadoCuestionario.getResumenInstance(), animated: true, completion: nil)
    }
    
    private func setupViews() {
        let labelsStackView = UIStackView(arrangedSubviews: [lbProgreso,lbScore])
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.distribution = .fillEqually
        view.addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            labelsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            labelsStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.10)
        ])
        
        self.view.addSubview(tvPregunta)
        NSLayoutConstraint.activate([
            tvPregunta.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor),
            tvPregunta.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tvPregunta.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tvPregunta.heightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.20),
        ])
        
        let bottomPortionContainer = UIView()
        
        bottomPortionContainer.layer.shadowColor = UIColor.lightGray.cgColor
        bottomPortionContainer.layer.shadowOpacity = 0.5
        bottomPortionContainer.layer.shadowOffset = .zero
        bottomPortionContainer.layer.shadowRadius = 10
        bottomPortionContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomPortionContainer)
        NSLayoutConstraint.activate([
            bottomPortionContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomPortionContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomPortionContainer.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75),
            bottomPortionContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        bottomPortionContainer.addSubview(btnSiguiente)
        NSLayoutConstraint.activate([
            btnSiguiente.leadingAnchor.constraint(equalTo: bottomPortionContainer.leadingAnchor, constant: 10),
            btnSiguiente.trailingAnchor.constraint(equalTo: bottomPortionContainer.trailingAnchor, constant: -10),
            btnSiguiente.heightAnchor.constraint(equalToConstant: 50),
            btnSiguiente.bottomAnchor.constraint(equalTo: bottomPortionContainer.bottomAnchor, constant: -20)
        ])
        

        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 1
        bottomPortionContainer.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: bottomPortionContainer.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: bottomPortionContainer.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: bottomPortionContainer.topAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(pregunta.opciones.count * cellHeight))
        ])
    }
}


extension QuestionController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pregunta.opciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = self.pregunta.opciones[indexPath.row]
        cell.textLabel?.font = Constants.App.Fonts.textFont
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.sizeToFit()
        cell.textLabel?.textColor = Constants.App.Colors.grayTint
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnswer = indexPath.row
    }
    
}
