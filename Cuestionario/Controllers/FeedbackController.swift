//
//  QuestionController.swift
//  Cuestionario
//
//  Created by user180523 on 11/4/20.
//

import UIKit

class FeedbackController: UIViewController{
    
//    var tableView : UITableView
    
    private let imageView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .lightGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    private let tvFeedback: UITextView = {
       let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Feedback", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.titleFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.orangeTint])
        attributedText.append(NSMutableAttributedString(string: "\n\nRecuerda que la LFDA establece que se debe de ... Lorem ipsum Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pharetra velit quis vulputate iaculis.", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.textFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint]))
        textView.attributedText = attributedText
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
    
    @IBAction private func terminarCuestionario() {
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        let attributedText = NSMutableAttributedString(string: "Calificación: \(DataSingleton.shared.cuestionarios[DataSingleton.shared.usuario.cuestionarioActual].getCalificacion()!)", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.titleFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.orangeTint])
        let feedbackString = DataSingleton.shared.cuestionarios[DataSingleton.shared.usuario.cuestionarioActual].getFeedback().joined(separator: "\n")
        attributedText.append(NSMutableAttributedString(string: "\n\n" + feedbackString, attributes: [NSAttributedString.Key.font: Constants.App.Fonts.textFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint]))
        self.tvFeedback.attributedText = attributedText
        
        self.view.backgroundColor = .white
        let topPortionView = UIView()
        topPortionView.translatesAutoresizingMaskIntoConstraints = false
        topPortionView.backgroundColor = .systemIndigo
        view.addSubview(topPortionView)
        
        NSLayoutConstraint.activate([
            topPortionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topPortionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topPortionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topPortionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.50)
        ])
        
        topPortionView.addSubview(imageView)
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

}
