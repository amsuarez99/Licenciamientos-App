//
//  PageCell.swift
//

import UIKit

class PageCell: UICollectionViewCell {
    
    // MARK: - HostedView
        weak var hostedView: UIView? {
            didSet {
              if let oldValue = oldValue {
                  oldValue.removeFromSuperview()
              }
              if let hostedView = hostedView {
                  hostedView.frame = contentView.bounds
                  contentView.addSubview(hostedView)
              }
            }
        }

        // MARK: - Reuse
        override func prepareForReuse() {
            super.prepareForReuse()

            hostedView = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
