//
//  MyAccountViewmodel.swift
//  CathaysecTestDemo1
//
//  Created by Giles on 2026/4/15.
//

import Foundation
import Combine

class MyAccountViewModel {
    
    // 輸出：畫面綁定的資料
    @Published private(set) var services: [AppServiceItem] = []
    
    // 依賴注入的 UseCase
    private let useCase: FetchAppServicesUseCase
    
    // 💡 修正 1：這裡是用等號 (=) 來建立一個空的 Set
    private var cancellables = Set<AnyCancellable>()
    
    // 💡 修正 2：移除莫名其妙的 protocol 區塊，直接寫 init
    init(useCase: FetchAppServicesUseCase) {
        self.useCase = useCase
    }
    
    // 💡 修正 3：函數宣告修正，並改為 loadServices (加 s) 以符合你 Controller 裡的呼叫
    func loadServices() {
        useCase.execute()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] items in
                      self?.services = items
                  })
            .store(in: &cancellables)
    }
    
} 
