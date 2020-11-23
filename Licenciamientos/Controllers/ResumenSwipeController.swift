//
//  SwipeController.swift
//  Cuestionario
//
//  Created by user180523 on 11/4/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class ResumenSwipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var viewControllers : [UIViewController]!
    
    private let btnAtras: UIButton = {
        let btn = UIButton()
        btn.setTitle("ATRÁS", for: .normal)
        btn.setTitleColor(Constants.App.Colors.lightGrayTint, for: .normal)
        btn.titleLabel?.font = Constants.App.Fonts.markupFont
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.textAlignment = .center
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
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return btn
    }()
    
    @IBAction private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, viewControllers.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = viewControllers.count
        pc.currentPageIndicatorTintColor = Constants.App.Colors.orangeTint
        pc.pageIndicatorTintColor = Constants.App.Colors.lightGrayTint
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        
        self.view.backgroundColor = .white
        setupBotones()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let newPage = Int(x / view.frame.width)
        pageControl.currentPage = newPage
       
    }
    
    private func setupBotones() {
        
        let controles = UIStackView(arrangedSubviews: [btnAtras, pageControl, btnSiguiente])
        controles.translatesAutoresizingMaskIntoConstraints = false
        controles.distribution = .fillProportionally
        self.view.addSubview(controles)
        NSLayoutConstraint.activate([
            controles.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            controles.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            controles.heightAnchor.constraint(equalToConstant: 50),
            controles.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            btnAtras.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
            btnSiguiente.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: controles.topAnchor, constant: -20)
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
        
        return viewControllers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PageCell
        
        self.addChild(self.viewControllers[indexPath.item])
        cell.hostedView = self.viewControllers[indexPath.item].view
       
        self.viewControllers[indexPath.item].view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.viewControllers[indexPath.item].view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            self.viewControllers[indexPath.item].view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            self.viewControllers[indexPath.item].view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            self.viewControllers[indexPath.item].view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        
        self.viewControllers[indexPath.item].didMove(toParent: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }


}
