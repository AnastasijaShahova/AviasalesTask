//
//  FlightListScrollView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 03.09.2024.
//

import SwiftUI

struct FlightListScrollModel {
    let cellModels: [FlightListCellModel]
    let headerModel: TitleSubtitleModel
}

struct FlightListScrollView: View {
    let model: FlightListScrollModel
    let factory: FlightViewModelFactoryProtocol
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            VStack {
                Spacer()
                TitleSubtitleView(model: model.headerModel)
                    .accessibilityLabel("flightDirectionHeading")
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(model.cellModels, id: \.id) { item in
                            NavigationLink(destination: FlightDetailsView(model: factory.createFlightDetailsModel(from: item))) {
                                FlightListCellView(model: item)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                }
                .navigationTitle("Все билеты")
                .navigationBarHidden(true)
                .accessibilityLabel("flightListScroll")
            }
        }
    }
}

struct FlightListScrollView_Previews: PreviewProvider {
    static var previews: some View {
        let cellModels = [
            FlightListCellModel(
                id: UUID().uuidString,
                headerModel: FlightInfoCellHeaderModel(
                    price: "15 000 ₽",
                    companyName: "Аэрофлот",
                    warningTitle: "Осталось 4 билета по этой цене"
                ),
                infoModel: InfoPairModel(
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
                ),
                isCheapest: true, passengersCount: 1
            ),
            FlightListCellModel(
                id: UUID().uuidString,
                headerModel: FlightInfoCellHeaderModel(
                    price: "20 000 ₽",
                    companyName: "S7",
                    warningTitle: nil
                ),
                infoModel: InfoPairModel(
                    pairs: [
                        TitleSubtitlePair(
                            leftModel: TitleSubtitleModel(
                                title: "Москва",
                                subtitle: "MOW",
                                alignment: .leading
                            ),
                            rightModel: TitleSubtitleModel(
                                title: "12:00",
                                subtitle: "5 сен, ср",
                                alignment: .trailing
                            )
                        ),
                        TitleSubtitlePair(
                            leftModel: TitleSubtitleModel(
                                title: "Новосибирск",
                                subtitle: "OVB",
                                alignment: .leading
                            ),
                            rightModel: TitleSubtitleModel(
                                title: "16:00",
                                subtitle: "5 сен, ср",
                                alignment: .trailing
                            )
                        )
                    ]
                ),
                isCheapest: false, passengersCount: 1
            )
        ]
        
        let headerModel = TitleSubtitleModel(title: "Москва-Питер", subtitle: "1 человек", alignment: .center)
        
        let model = FlightListScrollModel(
            cellModels: cellModels,
            headerModel: headerModel
        )
        
        let flightViewModelFactory = FlightViewModelFactory(formatterService: FormatterService())

        NavigationView {
            FlightListScrollView(model: model, factory: flightViewModelFactory)
        }
    }
}
