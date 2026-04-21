//
//  MyAccountViewController.swift
//  CathaysecTestDemo1
//
//  Created by Giles on 2026/4/15.
//

import UIKit
import Combine

class MyAccountViewController: UIViewController {
    
    // 💡 修正 1：這裡要是 MyAccountViewModel，不是 ViewController！
    private let viewModel: MyAccountViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // 💡 修正 2：使用 UICollectionViewCompositionalLayout 才是正確的語法
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            // 設定每一列 3 個正方形格子
            let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                   heightDimension: .fractionalWidth(1.0))
            let items = NSCollectionLayoutItem(layoutSize: itemsSize)
            items.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            // Group 的高度也要跟著變成 1/3，確保格子是正方形
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(1/3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [items])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // 💡 修正 3：保留唯一一個乾淨、正確的 Init (建構子)
    init(viewModel: MyAccountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // 💡 修正 4：fatalError 裡面只需要傳遞字串，且 init 必須加上問號 (?)
    required init?(coder: NSCoder) {
        fatalError("不支援 Storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        bindViewModel()       // 2. 戴上對講機耳機 (綁定資料)
            
        viewModel.loadServices() // 3. 呼叫廚房：「開始出菜！」
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .systemGray5
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ServiceGridCell.self, forCellWithReuseIdentifier: ServiceGridCell.reuseIdentifier)
        
        // 1️⃣ 第一步：【必須先加入畫面】(認祖歸宗)
        view.addSubview(collectionView)
        
        // 2️⃣ 第二步：【才能設定約束條件】(算距離)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
      
    }
    
    private func bindViewModel() {
        viewModel.$services
            .receive(on: DispatchQueue.main) // 確保在主執行緒更新畫面
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }.store(in: &cancellables)
    }
}

// MARK: - UICollectionViewDataSource
extension MyAccountViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceGridCell.reuseIdentifier, for: indexPath) as? ServiceGridCell else {
            return UICollectionViewCell()
        }
        
        let item = viewModel.services[indexPath.row]
        cell.configure(with: item) // 將資料交給 Cell 去渲染
       // print("👉 目前 CollectionView 拿到的資料量：\(viewModel.services.count)")
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MyAccountViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1. 從 ViewModel 根據 index 拿到對應的資料物件
        let selectedItem = viewModel.services[indexPath.row]
        
      //  print("👉 點擊了：\(selectedItem.title)")
        
        // 2. 實體化下一頁，並把資料丟進去
        let detailVC = ServiceDetailViewController(item: selectedItem)
        
        // 3. 使用 NavigationController 推進下一頁
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
