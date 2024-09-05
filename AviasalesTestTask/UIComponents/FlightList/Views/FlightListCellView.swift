//
//  FlightListCellView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import SwiftUI

struct FlightListCellModel {
    let id: String
    let headerModel: FlightInfoCellHeaderModel
    let infoModel: InfoPairModel
    let isCheapest: Bool
    let passengersCount: Int
}

struct FlightListCellView: View {
    let model: FlightListCellModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
            
            if model.isCheapest {
                CheapestPriceView()
                    .offset(x: 8, y: -10)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                FlightInfoCellHeaderView(model: model.headerModel)
                TitleSubtitlePairView(model: model.infoModel)
            }
            .foregroundColor(.primary)
            .padding(16)
        }
        
    }
}

struct FlightListCellView_Previews: PreviewProvider {
    static var previews: some View {
        let headerModel = FlightInfoCellHeaderModel(
            price: "15 000 ₽",
            companyName: "Аэрофлот",
            warningTitle: nil
        )
        
        let infoModel = InfoPairModel(
            pairs: [
                TitleSubtitlePair(
                    leftModel: TitleSubtitleModel(
                        title: "Москва",
                        subtitle: "MOW",
                        alignment: .leading
                    ),
                    rightModel: TitleSubtitleModel(
                        title: "10:00",
                        subtitle: "4 сен, вт",
                        alignment: .trailing
                    )
                ),
                TitleSubtitlePair(
                    leftModel: TitleSubtitleModel(
                        title: "Санкт-Петербург",
                        subtitle: "LED",
                        alignment: .leading
                    ),
                    rightModel: TitleSubtitleModel(
                        title: "11:30",
                        subtitle: "4 сен, вт",
                        alignment: .trailing
                    )
                )
            ]
        )
                
        let model = FlightListCellModel(
            id: UUID().uuidString,
            headerModel: headerModel,
            infoModel: infoModel,
            isCheapest: true, passengersCount: 1
        )
        
        FlightListCellView(model: model)
            .previewLayout(.sizeThatFits)
    }
}
