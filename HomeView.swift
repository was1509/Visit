//
//  HomeView.swift
//  Visit
//
//  Created by Wasitul Hoque on 25/12/22.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State private var homeview = true
    @State private var instructions = false
    @State private var isanimation = false
    @State private var returnToContentView = false
    var body: some View {
        ZStack {
            if returnToContentView == true {
                ContentView()
            }
            else if homeview == false {
                MapView()
            }
            else {
            Color("FirstViewColor")
                .ignoresSafeArea(.all , edges: .all)
                
                VStack {
                    
                    VStack(spacing: 20) {
                        HStack {
                            Button(action: {returnToContentView = true}) {
                                Text("\(Image(systemName: "chevron.backward")) Back")
                                    .foregroundColor(.blue)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 20))
                            }
                            Spacer()
                        }.padding(.horizontal)
                        
                    // Title
                        
                    Text("Welcome to Vist!")
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                        .foregroundColor(.teal)
                    
                    Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.blue)
                            .font(.system(size: 55))
                    VStack{
                        // Instructions
                        
                        HStack {
                            Text("Instructions: ")
                                .font(.system(size: 30))
                                .fontWeight(.heavy)
                                .foregroundColor(.teal)
                            Spacer()
                        }.padding()
                        
                        VStack(spacing: 30){
                            HStack {
                                Text("1. Please ensure your device location services are turned on.")
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                    .foregroundColor(.blue)
                                Spacer()
                            }.padding(.horizontal)
                            
                            HStack {
                                Text("2. Please ensure you have enough battery on you device for your hike.")
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                    .foregroundColor(.blue)
                                Spacer()
                            }.padding(.horizontal)
                            
                            HStack {
                                Text("3. Lastly, please make sure to take necessities such as food and water.")
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                    .foregroundColor(.blue)
                                Spacer()
                            }.padding(.horizontal)
                        }
                    }
                    HStack{
                        Text("I have read the instructions.")
                            .font(.system(size: 22))
                            .fontWeight(.medium)
                            .foregroundColor(.purple)
                        if instructions == false {
                            Button(action: {instructions = true}){
                                Image(systemName: "checkmark.circle")
                                    .font(.system(size: 35))
                                    .foregroundColor(.red)
                            }
                        }
                        if instructions == true {
                                Button(action: {instructions = false}) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 35))
                                        .foregroundColor(.green)
                                }
                            }
                    }
                    if instructions == false {
                        ZStack {
                            Text("Start Hike!")
                                    .font(.system(size: 23))
                                    .foregroundColor(.gray)
                                    .fontWeight(.medium)
                                    .padding()
                                .overlay(RoundedRectangle(cornerRadius: 25).fill(Color.gray).opacity(0.1).shadow(radius: 7)).padding()
                        }
                        .onAppear(perform: {isanimation = false})
                    }
                    if instructions == true {
                        ZStack {
                            Button(action:{homeview = false}){
                                Text("Start Hike!")
                                    .font(.system(size: 23))
                                    .fontWeight(.medium)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 25).fill(Color.teal).opacity(0.15).shadow(radius: 7)).padding()
                            }
                            .opacity(isanimation ? 1 : 0)
                            .animation(.easeOut(duration: 0.7) , value: isanimation)
                        }
                        .onAppear(perform: {isanimation = true})
                    }
                    Spacer()
                    }
                }
        }
    }
}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
