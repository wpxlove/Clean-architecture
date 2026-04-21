//
//  AppServiceItem.swift
//  CathaysecTestDemo1
//
//  Created by Giles on 2026/4/15.
//

import Foundation
struct  AppServiceItem:Hashable {
    let id:UUID = UUID()
    let title:String
    let iconName:String
    let badge:String?
}
