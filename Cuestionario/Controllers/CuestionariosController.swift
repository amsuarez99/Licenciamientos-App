//
//  CuestionariosController.swift
//  Cuestionario
//
//  Created by user180523 on 11/5/20.
//

import UIKit

class CuestionariosController: UIViewController, cuestionarioController {
    
    let data = ["Ley Federal de Derechos de Autor", "Recursos de uso libre", "Cuestionario3", "Cuestionario4"]
    let numberOfQuestions = 5
    let usuario = Usuario()
    private var cuestionario = Cuestionario(tema: "LFDA", descripcion: "Descripción de cuestionario", foto: "foto_cuestionario1", preguntas:
            [
                Pregunta(pregunta: "La Ley Federal de Derechos de Autor establece que: ", opciones: ["La salvaguarda y promoción del acervo cultural de la Nación", "Pagarle a los autores de obras literarias", "Reconocer a los autores por cada obra literaria que realice", "Todas las anteriores"], indiceRespuesta: 0),
                Pregunta(pregunta: "Esta es la pregunta 2?", opciones: ["Opción 1", "Opción 2", "Opción 3"], indiceRespuesta: 1),
                Pregunta(pregunta: "Pregunta 3", opciones: ["opcion1", "opcion2", "opcion3", "opcion4"], indiceRespuesta: 2)
            ]
    )
    private lazy var resumenVC = ResumenSwipeController(collectionViewLayout: UICollectionViewLayout())

    private let tableView : UITableView = {
       let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let titulo: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "CUESTIONARIOS", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.titleFont, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(TemaCell.self, forCellReuseIdentifier: "cell")
        setupView()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.view.addSubview(titulo)
        NSLayoutConstraint.activate([
            titulo.bottomAnchor.constraint(equalTo: self.tableView.topAnchor, constant: -50),
            titulo.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    // MARK: Protocol Cuestionario Controller
    func getResumenInstance() -> ResumenSwipeController {
        return resumenVC
    }
    
    func getPregunta() -> Pregunta? {
        usuario.contestoPregunta()
        let preguntaActual = usuario.getPreguntaActual()
        if preguntaActual == cuestionario.getPreguntas().count {
            return nil
        }
        return cuestionario.getPregunta(for: usuario.getPreguntaActual())
    }
    
    func getNumPregunta() -> Int {
        return usuario.getPreguntaActual()
    }
    
    func getNumPreguntas() -> Int {
        return cuestionario.getPreguntas().count
    }
    
}


// MARK: Table Protocols
extension CuestionariosController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TemaCell
        cell.nameLabel.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (self.tableView.frame.height) * 0.15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Sets the question controller and assigns it to self so that it can retrieve resumenController
        let qVC = QuestionController()

        usuario.setPreguntaActual(0)
        qVC.pregunta = cuestionario.getPregunta(for: usuario.getPreguntaActual())
        qVC.delegadoCuestionario = self
        qVC.title = cuestionario.getTema()
        self.navigationController?.pushViewController(qVC, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let seconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.present(self.resumenVC, animated: true, completion: nil)
        }
    }
}

// MARK: TableView Cell
class TemaCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Answer"
        label.font = Constants.App.Fonts.markupFont
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardView : UIView = {
        let v = UIView()
        v.backgroundColor = .systemIndigo
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 15
        v.clipsToBounds = true
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            cardView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
        
        cardView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
    
}
