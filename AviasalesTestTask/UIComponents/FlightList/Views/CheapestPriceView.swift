//
//  CheapestPriceView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import SwiftUI

struct CheapestPriceView: View {    
    var body: some View {
        Text("Самый дешевый")
            .foregroundColor(.white)
            .font(.system(size: 13, weight: .bold))
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(RoundedRectangle(cornerRadius: 100)
                .foregroundColor(.green))
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        CheapestPriceView()
    }
}
