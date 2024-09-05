//
//  FlightInfoCellView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import SwiftUI

struct FlightInfoCellModel {
    let companyName: String
    let ticketDetailsModel: InfoPairModel
}

struct FlightInfoCellView: View {
    let model: FlightInfoCellModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                .frame(maxWidth: .infinity, maxHeight: 160, alignment: .center)
                .padding(.horizontal, 16)
            VStack(spacing: 15) {
                HStack(spacing: 10) {
                    Image(model.companyName)
                    Text(model.companyName)
                        .frame(alignment: .center)
                        .font(.system(size: 15, weight: .semibold))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                TitleSubtitlePairView(model: model.ticketDetailsModel)
            }
            .padding(.horizontal, 30)
            .frame(height: 160)
        }
    }
}

struct FlightInfoCellView_Previews: PreviewProvider {
    static var previews: some View {
        let leftModel1 = TitleSubtitleModel(title: "Москва", subtitle: "MOW", alignment: .leading)
        let rightModel1 = TitleSubtitleModel(title: "20:50", subtitle: "3 сен, пн", alignment: .trailing)
        
        let leftModel2 = TitleSubtitleModel(title: "Санкт-Петербург", subtitle: "LED", alignment: .leading)
        let rightModel2 = TitleSubtitleModel(title: "22:05", subtitle: "3 сен, пн", alignment: .trailing)
        
        let pair1 = TitleSubtitlePair(leftModel: leftModel1, rightModel: rightModel1)
        let pair2 = TitleSubtitlePair(leftModel: leftModel2, rightModel: rightModel2)
        
        let infoPairModel = InfoPairModel(pairs: [pair1, pair2])
        
        let model = FlightInfoCellModel(
            companyName: "Аэрофлот",
            ticketDetailsModel: infoPairModel
        )
        
        FlightInfoCellView(model: model)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
