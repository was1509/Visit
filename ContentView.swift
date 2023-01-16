//
//  ContentView.swift
//  Visit
//
//  Created by Wasitul Hoque on 25/12/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var goToHomeView: Bool = true
    @State private var contentviewLogin: Bool = true
    @State private var animation: Bool = false
//    @Binding var region: MKCoordinateRegion
//    @Binding var destinationRegion: MKCoordinateRegion
    var body: some View {
        if goToHomeView == false{
            HomeView()
        }
       else if contentviewLogin == false {
            //LoginView()
        }
        else {
        ZStack {
            // Background Color
            Color("FirstViewColor")
                .ignoresSafeArea(.all , edges: .all)
            
            // Background Color
            VStack(spacing: 20) {
                // Title
                
                Spacer()
                VStack(alignment: .leading) {
                    Text("Visit.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.teal)
                    
                    Text("Hikes to remember!")
                        .font(.title3)
                        .foregroundColor(.green)
                        .fontWeight(.medium)
                }
                // Header Animation
                .opacity(animation ? 1 : 0)
                .offset(y: animation ? 0 : -40)
                .animation(.easeOut(duration: 1), value: animation)
                
                Spacer()
                
                ZStack{
                    ZStack{
                        Circle()
                            .stroke(.blue.opacity(0.15) , lineWidth: 40)
                            .frame(width: 300, height: 300, alignment: .center)
                        Circle()
                            .stroke(.teal.opacity(0.2) , lineWidth: 80)
                            .frame(width: 300, height: 300, alignment: .center)
                        Circle()
                            .stroke(.green.opacity(0.1) , lineWidth: 80)
                            .frame(width: 200, height: 200, alignment: .center)
                    }
                }
                .opacity(animation ? 1 : 0)
                .animation(.easeOut(duration: 1.7), value: animation)
                
                Spacer()
                
                ZStack{
                    
                    // Next Button
                    
                    Button(action:{goToHomeView = false}){
                        Text("Next")
                            .font(.system(size: 23))
                            .fontWeight(.medium)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 25).fill(Color.teal).opacity(0.15).shadow(radius: 7)).padding()
                    }
                    // Button animation
                    .opacity(animation ? 1 : 0)
                    .offset(y: animation ? 0 : 40)
                    .animation(.easeOut(duration: 1), value: animation)
                }
                .frame(height: 80, alignment: .center)
                .padding()
            }
        }
        .onAppear(perform: {animation = true})
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
