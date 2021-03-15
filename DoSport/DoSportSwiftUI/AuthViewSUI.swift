//
//  AuthViewSUI.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 12/03/2021.
//

#if canImport(SwiftUI)
import SwiftUI
#endif

import MapKit

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

@available(iOS 13.0, *)
struct CircleImage: View {
    
    var body: some View {
        Image("logo")
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 4))
            .shadow(radius: 10)
    }
}

@available(iOS 13.0, *)
struct AuthViewSUI: View {
    
    var body: some View {
        VStack {
            MapView()
                .frame(height: 250)
                .edgesIgnoringSafeArea(.top)
            
            CircleImage()
                .offset(y: -100)
                .padding(.bottom, -40)
            
            VStack(alignment: .leading) {
                Text("Kamol")
                    .font(.title)
                
                HStack {
                    Text("Ibragimov")
                        .font(.subheadline)
                    
                    Spacer()
                    Text("Abdurasul ogli")
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

@available(iOS 13.0, *)
struct AuthViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        AuthViewSUI()
    }
}
