//
//  FlightDetailsView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import SwiftUI

struct FlightDetailsModel {
    let buttonModel: FlightDetailsButtonModel
    let headerModel: PriceHeaderModel
    let informationModel: FlightInfoCellModel
    let title: String
}

struct FlightDetailsView: View {
    let model: FlightDetailsModel
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack {
                PriceHeaderView(model: model.headerModel)
                    .frame(alignment: .top)
                    .padding(.vertical, 10)
                VStack() {
                    Text(model.title)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .font(.system(size: 17, weight: .heavy))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    FlightInfoCellView(model: model.informationModel)
                }
                Spacer()
                BuyButtonView(model: model.buttonModel)
                    .padding(.bottom, 10)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FlightDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let buttonModel = FlightDetailsButtonModel(
            buttonTitle: "Купить билет за 17 830 ₽",
            alertMessage: "Билет куплен за 17 830 ₽"
        )
        
        let headerModel = PriceHeaderModel(
            price: "17 830 ₽",
            passengersCount: "Лучшая цена за 1 чел"
        )
        
        let leftModel1 = TitleSubtitleModel(title: "Москва", subtitle: "MOW", alignment: .leading)
        let rightModel1 = TitleSubtitleModel(title: "20:50", subtitle: "3 сен, пн", alignment: .trailing)
        
        let leftModel2 = TitleSubtitleModel(title: "Санкт-Петербург", subtitle: "LED", alignment: .leading)
        let rightModel2 = TitleSubtitleModel(title: "22:05", subtitle: "3 сен, пн", alignment: .trailing)
        
        let pair1 = TitleSubtitlePair(leftModel: leftModel1, rightModel: rightModel1)
        let pair2 = TitleSubtitlePair(leftModel: leftModel2, rightModel: rightModel2)
        
        let infoPairModel = InfoPairModel(pairs: [pair1, pair2])
        
        let informationModel = FlightInfoCellModel(
            companyName: "Аэрофлот",
            ticketDetailsModel: infoPairModel
        )
        
        let flightDetailsModel = FlightDetailsModel(
            buttonModel: buttonModel,
            headerModel: headerModel,
            informationModel: informationModel,
            title: "Москва — Санкт-Петербург"
        )
        
        FlightDetailsView(model: flightDetailsModel)
            .previewLayout(.sizeThatFits)
    }
}
