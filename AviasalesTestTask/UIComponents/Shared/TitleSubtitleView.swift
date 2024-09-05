//
//  TitleSubtitleView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import SwiftUI

struct TitleSubtitleModel {
    let title: String
    let subtitle: String
    let alignment: HorizontalAlignment
}

struct TitleSubtitleView: View {
    let model: TitleSubtitleModel
    
    var body: some View {
        VStack(alignment: model.alignment, spacing: 2) {
            Text(model.title)
                .font(.system(size: 15, weight: .semibold))
            Text(model.subtitle)
                .font(.system(size: 13))
                .foregroundColor(Color(UIColor.gray))
        }
    }
}

struct TitleSubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleSubtitleView(model: TitleSubtitleModel(
            title: "Москва",
            subtitle: "MOW",
            alignment: .leading
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
