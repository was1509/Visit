//
//  MapView.swift
//  Visit
//
//  Created by Wasitul Hoque on 28/12/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var next = false
    @State private var isMapView = true
    @StateObject var viewModel = MapViewModel()
    @State private var imageOffset: CGFloat = 0
    var body: some View {
        if isMapView == false {
            HomeView()
        }
        else if next == true {
            MapScreen(region: $viewModel.region, destinationRegion: $viewModel.destinationRegion)
        }
        else {
            ZStack {
                // Show Map
                
                Map(coordinateRegion: $viewModel.destinationRegion , showsUserLocation: true)
                    .accentColor(Color.blue)
                    .ignoresSafeArea(.all , edges: .all)
                    .onAppear {
                        viewModel.checkifLocationAvailable()
                    }
                HStack {
                    VStack {
                        Button(action: {isMapView = false}){
                            Text("\(                            Image(systemName: "chevron.backward")) Back")
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                        }
                        Spacer()
                    }
                    Spacer()
                }.padding()
                VStack {
                    Toggle(isOn: $next) {
                        HStack { Spacer()
                            Text("Show route").fontWeight(.semibold)
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 25).fill(Color.gray).opacity(0.2).shadow(radius: 7))
                            
                        }
                    }
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding()
                    
                    Spacer()
                }
            }
            Image(systemName: "mappin")
                .foregroundColor(.purple)
                .font(.system(size: 28))
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @State var presidioEntry = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.79190, longitude: -122.44776),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.79190, longitude: -122.44776),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    @Published var destinationRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.79190, longitude: -122.44776),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    var locationManager: CLLocationManager?
    
    func checkifLocationAvailable() {        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            
        }
        else {
            print("Location access denied.")
        }
    }
    
    


    func checkLocationAllowed() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location access denied.")
        case .denied:
            print("Location access denied.")
        case .authorizedAlways:
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            destinationRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: destinationRegion.center.latitude, longitude: destinationRegion.center.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        case .authorizedWhenInUse:
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            destinationRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: destinationRegion.center.latitude, longitude: destinationRegion.center.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        @unknown default:
            break
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAllowed()
    }
}




