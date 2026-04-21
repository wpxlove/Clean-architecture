//
//  ServiceGridCell.swift
//  CathaysecTestDemo1
//
//  Created by Giles on 2026/4/15.
//

import UIKit

class ServiceGridCell: UICollectionViewCell {
    //
    static let reuseIdentifier = "ServiceGridCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.contentMode = .center
               self.tintColor = UIColor(red: 0.0, green: 0.6, blue: 0.3, alpha: 1.0) 
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return   titleLabel
    }()
    
    private var badgeLabel : UILabel = {
        let label = UILabel()
            // 這裡只負責長相
            label.font = .systemFont(ofSize: 10, weight: .bold)
            label.textColor = .white
            label.textAlignment = .center
            label.layer.cornerRadius = 4
            label.layer.masksToBounds = true
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
    }()
    
    private func setupUI() {
        // 將元件加入畫面
                contentView.addSubview(iconImageView)
                contentView.addSubview(titleLabel)
                contentView.addSubview(badgeLabel)
        
        // 4. Auto Layout 排版設定
                NSLayoutConstraint.activate([
                    // 圖示：置中且稍微偏上
                    iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
                    iconImageView.widthAnchor.constraint(equalToConstant: 60),
                    iconImageView.heightAnchor.constraint(equalToConstant: 60),
                    
                    // 標題：在圖示正下方
                    titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
                    titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                    titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
                    
                    // 標籤：掛在圖示的右上角
                    // 修改這裡：
                        badgeLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -5), // 稍微往上飄出一點點比較好看
                        badgeLabel.trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10), // 往右邊飄出一點點
                    badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30),
                    badgeLabel.heightAnchor.constraint(equalToConstant: 16)
                ])
     
      
    }
        
    func configure(with item: AppServiceItem) {
        titleLabel.text = item.title
                
                // 使用 Apple 內建 SF Symbols，並統一大小
                let config = UIImage.SymbolConfiguration(pointSize: 36, weight: .light)
                iconImageView.image = UIImage(systemName: item.iconName, withConfiguration: config)
                
                // 處理 Badge 邏輯 (判斷 nil)
                if let badgeText = item.badge {
                    badgeLabel.text = badgeText
                    badgeLabel.isHidden = false
                    // 依照文字切換標籤顏色
                    badgeLabel.backgroundColor = badgeText == "HOT" ? .systemRed : .systemOrange
                } else {
                    // 如果是 nil，直接隱藏標籤
                    badgeLabel.isHidden = true
                }
    }
}

