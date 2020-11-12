//
//  PageCell.swift
//

import UIKit

class PageCell: UICollectionViewCell {
    
    // MARK: - HostedView

        // 1
        weak var hostedView: UIView? {
            didSet {
              // 2
              if let oldValue = oldValue {
                  oldValue.removeFromSuperview()
              }

              // 3
              if let hostedView = hostedView {
                  hostedView.frame = contentView.bounds
                  contentView.addSubview(hostedView)
              }
            }
        }

        // MARK: - Reuse

        // 4
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
