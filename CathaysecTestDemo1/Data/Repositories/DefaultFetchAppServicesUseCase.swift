//
//  DefaustGetUserSevicesUseCase.swift
//  CathaysecTestDemo1
//
//  Created by Giles on 2026/4/15.
//
import Foundation
import Combine

class DefaultFetchAppServicesUseCase: FetchAppServicesUseCase {
    func execute() -> AnyPublisher<[AppServiceItem], any Error> {
        let mockData = [
            AppServiceItem(title: "股票抽籤", iconName: "chart.bar", badge: nil),
            AppServiceItem(title: "研究報告", iconName: "doc.text.magnifyingglass", badge: "HOT"),
            AppServiceItem(title: "預收款券", iconName: "dollarsign.circle", badge: nil),
            AppServiceItem(title: "匯出帳務", iconName: "square.and.arrow.up", badge: "NEW"),
            AppServiceItem(title: "永續專區", iconName: "leaf", badge: nil),
            AppServiceItem(title: "股東會紀念品", iconName: "gift", badge: nil)
        ]
        return Just(mockData)
            .setFailureType(to: Error.self)
            .delay(for: 0.5, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
