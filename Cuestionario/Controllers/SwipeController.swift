//
//  SwipeController.swift
//  Cuestionario
//
//  Created by user180523 on 11/4/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class SwipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let historietas = [
        Historieta(color: .systemIndigo, headerText: "Caso 1", bodyText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tellus arcu, bibendum at tincidunt quis, laoreet nec enim. Sed nunc urna, rhoncus at sollicitudin at, rhoncus eu nunc. Sed rhoncus tincidunt mi. In consequat a lectus suscipit tristique. Proin vestibulum tortor vel leo sagittis tempus. In hac habitasse platea dictumst. Suspendisse porta ullamcorper mi quis mollis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Mauris tincidunt semper elit in varius."),
        Historieta(color: .cyan, headerText: "Caso 2", bodyText: "Aliquam sit amet ornare arcu. Curabitur fringilla est vitae mauris tristique, vel rutrum est dictum. Suspendisse rutrum laoreet risus, non viverra sapien placerat vitae. Proin efficitur ultricies velit, sed vehicula ante gravida at. Ut convallis, mauris maximus ultricies consequat, lacus urna ultrices arcu, ultricies convallis leo sem non libero. Donec scelerisque lorem in sagittis vehicula. Phasellus in tristique lectus. Sed vitae justo mauris. Suspendisse egestas venenatis orci id pharetra."),
        Historieta(color: .yellow, headerText: "Caso 3", bodyText: "Vivamus nec pulvinar urna. Fusce augue enim, eleifend ut elit imperdiet, volutpat condimentum orci. Mauris at ipsum dui. Phasellus dignissim quis ipsum sit amet euismod. Nullam in velit tincidunt, cursus tellus eu, vestibulum tellus. Proin sollicitudin vitae mauris vel ullamcorper. Quisque malesuada, augue at porta porta, libero nisi vestibulum nisl, vel commodo ligula est in leo. Fusce nec risus at ante laoreet placerat vitae maximus lacus."),
        Historieta(color: .yellow, headerText: "Caso 4", bodyText: "Vivamus nec pulvinar urna. Fusce augue enim, eleifend ut elit imperdiet, volutpat condimentum orci. Mauris at ipsum dui. Phasellus dignissim quis ipsum sit amet euismod. Nullam in velit tincidunt, cursus tellus eu, vestibulum tellus. Proin sollicitudin vitae mauris vel ullamcorper. Quisque malesuada, augue at porta porta, libero nisi vestibulum nisl, vel commodo ligula est in leo. Fusce nec risus at ante laoreet placerat vitae maximus lacus."),
        Historieta(color: .yellow, headerText: "Caso 5", bodyText: "Vivamus nec pulvinar urna. Fusce augue enim, eleifend ut elit imperdiet, volutpat condimentum orci. Mauris at ipsum dui. Phasellus dignissim quis ipsum sit amet euismod. Nullam in velit tincidunt, cursus tellus eu, vestibulum tellus. Proin sollicitudin vitae mauris vel ullamcorper. Quisque malesuada, augue at porta porta, libero nisi vestibulum nisl, vel commodo ligula est in leo. Fusce nec risus at ante laoreet placerat vitae maximus lacus."),
        Historieta(color: .yellow, headerText: "Caso 6", bodyText: "Vivamus nec pulvinar urna. Fusce augue enim, eleifend ut elit imperdiet, volutpat condimentum orci. Mauris at ipsum dui. Phasellus dignissim quis ipsum sit amet euismod. Nullam in velit tincidunt, cursus tellus eu, vestibulum tellus. Proin sollicitudin vitae mauris vel ullamcorper. Quisque malesuada, augue at porta porta, libero nisi vestibulum nisl, vel commodo ligula est in leo. Fusce nec risus at ante laoreet placerat vitae maximus lacus."),
        
    ]
    
    private let btnAtras: UIButton = {
        let btn = UIButton()
        btn.setTitle("ATRÁS", for: .normal)
        btn.setTitleColor(Constants.App.Colors.lightGrayTint, for: .normal)
        btn.titleLabel?.font = Constants.App.Fonts.markupFont
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return btn
    }()
    
    @IBAction private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    
    private let btnSiguiente: UIButton = {
        let btn = UIButton()
        btn.setTitle("SIG", for: .normal)
        btn.setTitleColor(Constants.App.Colors.orangeTint, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = Constants.App.Fonts.markupFont
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return btn
    }()
    
    @IBAction private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, historietas.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        print(nextIndex)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = historietas.count
        pc.currentPageIndicatorTintColor = Constants.App.Colors.orangeTint
        pc.pageIndicatorTintColor = Constants.App.Colors.lightGrayTint
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupBotones()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    private func setupBotones() {
        
        let controles = UIStackView(arrangedSubviews: [btnAtras, pageControl, btnSiguiente])
        controles.translatesAutoresizingMaskIntoConstraints = false
        controles.distribution = .fillEqually
        self.view.addSubview(controles)
        NSLayoutConstraint.activate([
            controles.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            controles.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            controles.heightAnchor.constraint(equalToConstant: 50),
            controles.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: controles.topAnchor)
        ])
    }
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historietas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PageCell
        let historieta = historietas[indexPath.item]
        cell.historieta = historieta
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}
