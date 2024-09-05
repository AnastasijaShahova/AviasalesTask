//
//  PriceHeaderView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import SwiftUI

struct PriceHeaderModel {
    let price: String
    let passengersCount: String
}

struct PriceHeaderView: View {
    let model: PriceHeaderModel
    
    var body: some View {
        VStack {
            Text(model.price)
                .font(.system(size: 35, weight: .heavy))
            Text(model.passengersCount)
                .font(.caption)
        }
    }
}

#Preview {
    PriceHeaderView(model: PriceHeaderModel(price: "4455", passengersCount: "Лучшая цена за 1 чел"))
}
