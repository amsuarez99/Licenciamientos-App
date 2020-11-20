//
//  CuestionariosController.swift
//  Cuestionario
//
//  Created by user180523 on 11/5/20.
//

import UIKit

class CuestionariosController: UIViewController, cuestionarioController {

    private var alerta: UIAlertController!
    private var cancelar: UIAlertAction!
    private var reiniciar: UIAlertAction!
    
    private let tableView : UITableView = {
       let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let titulo: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "CUESTIONARIOS", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.titleFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint])
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
        setupAlerta()
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
//        setupNav()
        self.tableView.reloadData()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
//    private func setupNav() {
//        UINavigationBar.appearance().barTintColor = .white
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Constants.App.Colors.grayTint]
//        UINavigationBar.appearance().tintColor = Constants.App.Colors.grayTint
//    }
    
    // MARK: Protocol Cuestionario Controller
    func getResumenInstance() -> ResumenSwipeController {
        return setupResumenController()
    }
    
    func getPregunta() -> Pregunta? {
        let cuestionarioActual = DataSingleton.shared.usuario.getCuestionarioActual()
        DataSingleton.shared.cuestionarios[cuestionarioActual].contestaPregunta()
        if !DataSingleton.shared.cuestionarios[cuestionarioActual].isTerminado() {
            return DataSingleton.shared.cuestionarios[cuestionarioActual].getPreguntaActual()
        }
        return nil
    }
    
    func getNumPreguntas() -> Int {
        let cuestionarioActual = DataSingleton.shared.usuario.cuestionarioActual
        return DataSingleton.shared.cuestionarios[cuestionarioActual].getNumPreguntas()
    }
    
}


// MARK: Table Protocols
extension CuestionariosController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataSingleton.shared.cuestionarios.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TemaCell
        cell.nameLabel.text = DataSingleton.shared.cuestionarios[indexPath.row].getTema()
        if DataSingleton.shared.cuestionarios[indexPath.row].isDisponible() {
            cell.cardView.backgroundColor = Constants.App.Colors.indigoTint
            cell.cardView.layer.shadowRadius = 7
            cell.isUserInteractionEnabled = true
        } else {
            cell.cardView.backgroundColor = .placeholderText
            cell.cardView.layer.shadowRadius = 0
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (self.tableView.frame.height) * 0.15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        // Sets the question controller and assigns it to self so that it can retrieve resumenController
        DataSingleton.shared.usuario.cuestionarioActual = indexPath.row
        if DataSingleton.shared.cuestionarios[indexPath.row].getProgreso() == nil {
            DataSingleton.shared.cuestionarios[indexPath.row].startCuestionario()
        } else if DataSingleton.shared.cuestionarios[indexPath.row].getProgreso() == 100 {
            self.present(alerta, animated: true, completion: nil)
            return
        }
        let qVC = setupQuestionController(indexPath.row)
        self.navigationController?.pushViewController(qVC, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Present resumen vc after a 0.5 second delay
        let rVC = setupResumenController()
        let seconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.present(rVC, animated: true, completion: nil)
        }
        
    }
    
    private func setupAlerta() {
        alerta = UIAlertController(title: "Alerta", message: "El cuestionario ya está terminado, ¿deseas reinciarlo?", preferredStyle: .alert)
        reiniciar = UIAlertAction(title: "Reiniciar", style: .default, handler: { (action) -> Void in
            DataSingleton.shared.cuestionarios[DataSingleton.shared.usuario.cuestionarioActual].startCuestionario()
            let innerAlerta = UIAlertController(title: "Alerta", message: "El cuestionario fue reiniciado", preferredStyle: .alert)
            let ok =  UIAlertAction(title: "OK", style: .default, handler: nil)
            innerAlerta.addAction(ok)
            self.present(innerAlerta, animated: true, completion: nil)
//            print("Usuario reinicia cuestionario")
        })
        cancelar = UIAlertAction(title: "Cancelar", style: .cancel) { (action) -> Void in
//            print("Usuario cancela el reiniciado")
        }
        alerta.addAction(reiniciar)
        alerta.addAction(cancelar)
    }
    

    
    private func setupQuestionController(_ index: Int) -> QuestionController {
        let qVC = QuestionController()
        qVC.pregunta = DataSingleton.shared.cuestionarios[index].getPreguntaActual()
        qVC.numPregunta = DataSingleton.shared.cuestionarios[index].getNumPreguntaActual()
        qVC.delegadoCuestionario = self
        qVC.title = DataSingleton.shared.cuestionarios[index].getTema()
        return qVC
    }
    
    private func setupResumenController() -> ResumenSwipeController {
        let rVC = ResumenSwipeController(collectionViewLayout: UICollectionViewLayout())
        let viewControllers = fetchResumenController()
        rVC.viewControllers = viewControllers
        rVC.collectionView.reloadData()
        rVC.pageControl.numberOfPages = viewControllers.count
        rVC.pageControl.currentPage = 0
        return rVC
    }
    
    private func fetchResumenController() -> [UIViewController] {
        var arr: [UIViewController] = []
        let historietas = DataSingleton.shared.cuestionarios[DataSingleton.shared.usuario.cuestionarioActual].historietas
        for historieta in historietas {
            let historietaController = HistorietaController()
            historietaController.historieta = historieta
            arr.append(historietaController)
        }
        arr.append(ResumenController())
        return arr
    }
}



// MARK: TableView Cell
class TemaCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Answer"
        label.font = Constants.App.Fonts.markupFontSmaller
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
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 10
        v.layer.masksToBounds = false
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
            cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.80),
            cardView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
        
        cardView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
    
}
