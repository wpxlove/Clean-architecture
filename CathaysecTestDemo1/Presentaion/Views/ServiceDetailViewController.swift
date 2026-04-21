

//
//  ServiceDetailViewController.swift
//  CathaysecTestDemo1
//
//  Created by Giles on 2026/4/15.
//

import UIKit

class ServiceDetailViewController: UIViewController {
    
    // 保持原有的 UILabel，移除重複的 textAlignment
    let demolabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    // ⚠️ [新增標記] 新增符合 UI Test 預期的「開始使用」按鈕
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("開始使用", for: .normal)
        button.setTitleColor(.white, for: .normal)
        // 設定為國泰綠色，符合測試案例的描述
        button.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.3, alpha: 1.0)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let item: AppServiceItem
     
    init(item: AppServiceItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
     
    required init?(coder: NSCoder) { fatalError() }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // ⚠️ [修改標記] 為了通過 UI Test，將 Navigation Bar 標題強制指定為「服務詳情」
        // 原寫法 title = item.title 會導致測試找不到 "服務詳情" 的 NavigationBar
        title = "服務詳情"

        demolabel.text = "你點選了：\(item.title)"
        
        // ⚠️ [修改標記] 將排版邏輯抽離至 setupUI 方法
        setupUI()
    }
    
    // ⚠️ [新增標記] 建立獨立的 UI 設定方法，改用 AutoLayout 確保元件正確顯示
    private func setupUI() {
        view.addSubview(demolabel)
        view.addSubview(startButton)
        
        // 關閉 AutoResizingMask 以啟用 AutoLayout 系統
        demolabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 設定約束條件 (Constraints)
        NSLayoutConstraint.activate([
            // demolabel 佈局：放在畫面 Y 軸中間偏上方 (-50)
            demolabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            demolabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            // startButton 佈局：放在 demolabel 的正下方 30pt 處
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: demolabel.bottomAnchor, constant: 30),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
