//
//  GetUserServicesUseCase.swift
//  CathaysecTestDemo1
//
//  Created by Giles on 2026/4/15.
//
import Foundation
import Combine

protocol FetchAppServicesUseCase{
    func execute() -> AnyPublisher<[AppServiceItem], Error>
}
