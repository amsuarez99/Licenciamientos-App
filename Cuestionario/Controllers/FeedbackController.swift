//
//  QuestionController.swift
//  Cuestionario
//
//  Created by user180523 on 11/4/20.
//

import UIKit

class FeedbackController: UIViewController{
    
    private var calificacion: Int!
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    private let tvFeedback: UITextView = {
       let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let btnTerminar: UIButton = {
        let btn = UIButton()
        btn.setTitle("Terminar", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = Constants.App.Colors.orangeTint
        btn.titleLabel?.font = Constants.App.Fonts.markupFont
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(terminarCuestionario), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calificacion = DataSingleton.shared.cuestionarios[DataSingleton.shared.usuario.cuestionarioActual].getCalificacion()!
        setupViews()
        setupFeedbackText()
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = .white
        
        let topPortionView = UIView()
        topPortionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topPortionView)
        
        NSLayoutConstraint.activate([
            topPortionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topPortionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topPortionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topPortionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.40)
        ])
        
        topPortionView.addSubview(imageView)
        imageView.image = calificacion < 70 ? UIImage(named: "commitment") : UIImage(named: DataSingleton.shared.cuestionarios[DataSingleton.shared.usuario.cuestionarioActual].getFoto())
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: topPortionView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: topPortionView.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: topPortionView.heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: topPortionView.widthAnchor, multiplier: 0.5)
        ])
        
        self.view.addSubview(btnTerminar)
        NSLayoutConstraint.activate([
            btnTerminar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            btnTerminar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            btnTerminar.heightAnchor.constraint(equalToConstant: 50),
            btnTerminar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        self.view.addSubview(tvFeedback)
        NSLayoutConstraint.activate([
            tvFeedback.topAnchor.constraint(equalTo: topPortionView.bottomAnchor, constant: 20),
            tvFeedback.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tvFeedback.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tvFeedback.bottomAnchor.constraint(lessThanOrEqualTo: btnTerminar.topAnchor)
        ])
        
    }

    private func setupFeedbackText (){
       
        let attributedText = NSMutableAttributedString(string: "Calificación: \(calificacion!)", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.titleFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.orangeTint])
        var feedbackString: String = ""
        switch calificacion! {
        case 0:
            feedbackString = "Asegurate de leer bien la lección y prestar atención a las historietas.\n¡Sigue intentándolo!\n\nRecuerda que:\n"
        case 70...99:
            feedbackString = "Felicidades, ¡obtuviste una calificación aprobatoria y conseguiste la medalla para este tema!\n\nSolamente recuerda que:\n"
            
        case 100:
            feedbackString = "¡Obtuviste la calificación máxima y conseguiste la medalla de este tema!"

        default:
            feedbackString = "¡Falta poco para el 70!\n\nRecuerda que:\n"
        }
        feedbackString.append(DataSingleton.shared.cuestionarios[DataSingleton.shared.usuario.cuestionarioActual].getFeedback().joined(separator: "\n"))
        
        attributedText.append(NSMutableAttributedString(string: "\n\n" + feedbackString, attributes: [NSAttributedString.Key.font: Constants.App.Fonts.textFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint]))
        
        self.tvFeedback.attributedText = attributedText
    }
    
    @IBAction private func terminarCuestionario() {
        let cuestionarioActual = DataSingleton.shared.usuario.cuestionarioActual
        let nextCuestionario = DataSingleton.shared.usuario.cuestionarioActual + 1
        if nextCuestionario < DataSingleton.shared.cuestionarios.count && calificacion! >= 70 { DataSingleton.shared.cuestionarios[nextCuestionario].isDisponible(true)
        }

        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
}
