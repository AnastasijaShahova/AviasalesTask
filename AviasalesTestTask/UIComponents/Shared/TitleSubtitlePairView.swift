//
//  FlightInfoView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import SwiftUI

struct TitleSubtitlePair: Identifiable {
    let id = UUID()
    let leftModel: TitleSubtitleModel
    let rightModel: TitleSubtitleModel
}

struct InfoPairModel {
    let pairs: [TitleSubtitlePair]
}

struct TitleSubtitlePairView: View {
    let model: InfoPairModel
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(model.pairs) { pair in
                HStack {
                    TitleSubtitleView(model: pair.leftModel)
                    Spacer()
                    TitleSubtitleView(model: pair.rightModel)
                }
            }
        }
    }
}

struct FlightInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let leftModel1 = TitleSubtitleModel(title: "Москва", subtitle: "MOW", alignment: .leading)
        
        let rightModel1 = TitleSubtitleModel(title: "20:50", subtitle: "3 сен, пн", alignment: .trailing)
        
        let leftModel2 = TitleSubtitleModel(title: "Санкт-Петербург", subtitle: "LED", alignment: .leading)
        let rightModel2 = TitleSubtitleModel(title: "22:05", subtitle: "3 сен, пн", alignment: .trailing)
        
        let pair1 = TitleSubtitlePair(leftModel: leftModel1, rightModel: rightModel1)
        let pair2 = TitleSubtitlePair(leftModel: leftModel2, rightModel: rightModel2)
        
        let flightInfoModel = InfoPairModel(pairs: [pair1, pair2])
        
        TitleSubtitlePairView(model: flightInfoModel)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
