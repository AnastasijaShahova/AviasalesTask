//
//  BuyButtonView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import SwiftUI

struct FlightDetailsButtonModel {
    let buttonTitle: String
    let alertMessage: String
}

struct BuyButtonView: View {
    @State private var showAlert = false
    
    let model: FlightDetailsButtonModel
    
    var body: some View {
        Button(action: {
            showAlert = true
        }) {
            Text(model.buttonTitle)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(Color.white)
                .font(.headline.weight(.semibold))
                .background(Color(red: 255/255, green: 111/255, blue: 50/255))
                .cornerRadius(10)
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(model.alertMessage),
                message: nil,
                dismissButton: .default(Text("Отлично"))
            )
        }
    }
}

struct BuyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BuyButtonView(model: FlightDetailsButtonModel(
            buttonTitle: "Купить билет за 200 рублей",
            alertMessage: "Билет куплен"
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
