
//
//  ContentView.swift
//  Google-Solution
//
//  Created by 왕서희 on 2023/02/19.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack{
            Color(r:254, g: 251, b: 233).ignoresSafeArea()
            VStack{
                HStack{
                    Text("분리수거 버리는 날은")
                        .font(.system(size: 20))
                    Text("수요일")
                        .font(.system(size: 35,weight: .bold))
                        .foregroundColor(Color.green)
                }.padding(25)
                HStack(spacing: 40){
                    Button(action: {print("paper")}){
                        Image("paper").renderingMode(.original)
                            .resizable()
                            .frame(width: 150, height: 120)
                    }
                    Button(action: {print("plastic")}){
                        Image("plastic").renderingMode(.original)
                            .resizable()
                            .frame(width: 150, height: 120)
                    }
                    
                }.padding()
                HStack(spacing: 40){
                    Button(action: {print("glass")}){
                        Image("glass").renderingMode(.original)
                            .resizable()
                            .frame(width: 150, height: 120)
                    }
                    Button(action: {print("styroform")}){
                        Image("styrofoam").renderingMode(.original)
                            .resizable()
                            .frame(width: 150, height: 120)
                    }
                    
                }.padding()
                HStack(spacing: 40){
                    Button(action: {print("can")}){
                        Image("can").renderingMode(.original)
                            .resizable()
                            .frame(width: 150, height: 120)
                    }
                    Button(action: {print("vinyl")}){
                        Image("vinyl").renderingMode(.original)
                            .resizable()
                            .frame(width: 150, height: 120)
                    }
                    
                }.padding()
                Spacer()
                Button(action: {
                    // 카메라 연결 
                    print("barcode")
                }){
                    Image("barcode").renderingMode(.original)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
