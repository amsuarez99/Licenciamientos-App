//
//  ViewController.swift
//  Cuestionario
//
//  Created by user180523 on 11/2/20.
//

import UIKit

class RootViewController: UIViewController {
    
    private let titulo: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: Constants.App.appName, attributes: [NSAttributedString.Key.font: Constants.App.Fonts.titleFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint])
        attributedText.append(NSAttributedString(string: "\n\n\nAprende las bases de esta ley, así como los licenciamientos y recursos de uso libre.", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.markupFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.lightGrayTint]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let btnCuestionarios: UIButton = {
        let btn = UIButton()
        btn.setTitle("Licenciamientos", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = Constants.App.Colors.orangeTint
        btn.titleLabel?.font = Constants.App.Fonts.markupFont
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnCuestionariosAction), for: .touchUpInside)
        return btn
    }()
    
    private let btnMedallas: UIButton = {
        let btn = UIButton()
        btn.setTitle("Medallas", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = Constants.App.Colors.orangeTint
        btn.titleLabel?.font = Constants.App.Fonts.markupFont
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnMedallasAction), for: .touchUpInside)
        return btn
    }()
    
    @IBAction private func btnCuestionariosAction() {
        let cuestionarioVC = CuestionariosController()
        self.navigationController?.pushViewController(cuestionarioVC, animated: true)
    }
    
    @IBAction private func btnMedallasAction() {
        let medallaVC = MedallasController(collectionViewLayout: UICollectionViewLayout())
        self.navigationController?.pushViewController(medallaVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        let textoContainerView = UIView()
        textoContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textoContainerView)
        NSLayoutConstraint.activate([
            textoContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textoContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            textoContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textoContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        textoContainerView.addSubview(titulo)
        NSLayoutConstraint.activate([
            titulo.centerYAnchor.constraint(equalTo: textoContainerView.centerYAnchor),
            titulo.leadingAnchor.constraint(equalTo: textoContainerView.leadingAnchor, constant: 20),
            titulo.trailingAnchor.constraint(equalTo: textoContainerView.trailingAnchor,constant: -20)
        ])
        
        self.view.addSubview(btnCuestionarios)
        NSLayoutConstraint.activate([
            btnCuestionarios.topAnchor.constraint(equalTo: textoContainerView.bottomAnchor),
            btnCuestionarios.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            btnCuestionarios.heightAnchor.constraint(equalToConstant: 50),
            btnCuestionarios.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75)
        ])
        
        self.view.addSubview(btnMedallas)
        NSLayoutConstraint.activate([
            btnMedallas.topAnchor.constraint(equalTo: btnCuestionarios.bottomAnchor, constant: 20),
            btnMedallas.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            btnMedallas.heightAnchor.constraint(equalToConstant: 50),
            btnMedallas.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75)
        ])
    }
}
