//
//  FlightDetailsHeaderView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import SwiftUI

struct FlightInfoCellHeaderModel {
    let price: String
    let companyName: String
    let warningTitle: String?
}

struct FlightInfoCellHeaderView: View {
    let model: FlightInfoCellHeaderModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(model.price)
                    .font(.system(size: 19, weight: .semibold))
                    .foregroundColor(Color(UIColor.systemBlue))
                Spacer()
                Image(model.companyName)
                    .resizable(resizingMode: .stretch)
                    .frame(width: 26, height: 26)
                    .fixedSize()
            }
            
            if let title = model.warningTitle {
                Text(title)
                    .font(.system(size: 13))
                    .foregroundColor(Color(UIColor.systemRed))
            }
        }
    }
}

struct TicketListCellHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FlightInfoCellHeaderView(
            model: FlightInfoCellHeaderModel(
                price: "17 830 ₽",
                companyName: "Аэрофлот",
                warningTitle: "Только 2 билета осталось!"
            )
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
