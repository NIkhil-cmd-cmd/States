//
//  ContentView.swift
//  StateListsApp
//
//  Created by Nikhil Krishnaswamy on 5/16/23.
//
import MapKit
import CoreLocation
import SwiftUI

struct States: Identifiable {
    let id = UUID()
    let name: String
    let abbreviation: String
    let flagImageName: String
    let stateSealImageName: String
    let capitalCity: String
    let largestCity: String
    let population: String
    let area: String
}

class SearchState: ObservableObject {
    @Published var searchText = ""
}

class ImageAnimationState: ObservableObject {
    @Published var isFlagImageVisible = false
    @Published var isSealImageVisible = false
}

class MapState: ObservableObject {
    @Published var showMap = false
}

struct StateListView: View {
    @StateObject private var searchState = SearchState()
    
    let states: [States] = [
        States(name: "Alabama", abbreviation: "AL", flagImageName: "alabama_flag", stateSealImageName: "alabama_seal", capitalCity: "Montgomery", largestCity: "Birmingham", population: "4.9 million", area: "52,419 sq mi"),
        States(name: "Alaska", abbreviation: "AK", flagImageName: "alaska_flag", stateSealImageName: "alaska_seal", capitalCity: "Juneau", largestCity: "Anchorage", population: "731,545", area: "663,267 sq mi"),
        States(name: "Arizona", abbreviation: "AZ", flagImageName: "arizona_flag", stateSealImageName: "arizona_seal", capitalCity: "Phoenix", largestCity: "Phoenix", population: "7.3 million", area: "113,990 sq mi"),
        States(name: "Arkansas", abbreviation: "AR", flagImageName: "arkansas_flag", stateSealImageName: "arkansas_seal", capitalCity: "Little Rock", largestCity: "Little Rock", population: "3 million", area: "53,179 sq mi"),
        States(name: "California", abbreviation: "CA", flagImageName: "california_flag", stateSealImageName: "california_seal", capitalCity: "Sacramento", largestCity: "Los Angeles", population: "39.5 million", area: "163,696 sq mi"),
        States(name: "Colorado", abbreviation: "CO", flagImageName: "colorado_flag", stateSealImageName: "colorado_seal", capitalCity: "Denver", largestCity: "Denver", population: "5.8 million", area: "104,094 sq mi"),
        States(name: "Connecticut", abbreviation: "CT", flagImageName: "connecticut_flag", stateSealImageName: "connecticut_seal", capitalCity: "Hartford", largestCity: "Bridgeport", population: "3.6 million", area: "5,543 sq mi"),
        States(name: "Delaware", abbreviation: "DE", flagImageName: "delaware_flag", stateSealImageName: "delaware_seal", capitalCity: "Dover", largestCity: "Wilmington", population: "989,948", area: "1,949 sq mi"),
        States(name: "Florida", abbreviation: "FL", flagImageName: "florida_flag", stateSealImageName: "florida_seal", capitalCity: "Tallahassee", largestCity: "Jacksonville", population: "21.5 million", area: "65,757 sq mi"),
        States(name: "Georgia", abbreviation: "GA", flagImageName: "georgia_flag", stateSealImageName: "georgia_seal", capitalCity: "Atlanta", largestCity: "Atlanta", population: "10.6 million", area: "59,425 sq mi"),
        States(name: "Hawaii", abbreviation: "HI", flagImageName: "hawaii_flag", stateSealImageName: "hawaii_seal", capitalCity: "Honolulu", largestCity: "Honolulu", population: "1.4 million", area: "10,931 sq mi"),
        States(name: "Idaho", abbreviation: "ID", flagImageName: "idaho_flag", stateSealImageName: "idaho_seal", capitalCity: "Boise", largestCity: "Boise", population: "1.8 million", area: "83,569 sq mi"),
        States(name: "Illinois", abbreviation: "IL", flagImageName: "illinois_flag", stateSealImageName: "illinois_seal", capitalCity: "Springfield", largestCity: "Chicago", population: "12.8 million", area: "57,914 sq mi"),
        States(name: "Indiana", abbreviation: "IN", flagImageName: "indiana_flag", stateSealImageName: "indiana_seal", capitalCity: "Indianapolis", largestCity: "Indianapolis", population: "6.7 million", area: "36,418 sq mi"),
        States(name: "Iowa", abbreviation: "IA", flagImageName: "iowa_flag", stateSealImageName: "iowa_seal", capitalCity: "Des Moines", largestCity: "Des Moines", population: "3.2 million", area: "56,272 sq mi"),
        States(name: "Kansas", abbreviation: "KS", flagImageName: "kansas_flag", stateSealImageName: "kansas_seal", capitalCity: "Topeka", largestCity: "Wichita", population: "2.9 million", area: "82,278 sq mi"),
        States(name: "Kentucky", abbreviation: "KY", flagImageName: "kentucky_flag", stateSealImageName: "kentucky_seal", capitalCity: "Frankfort", largestCity: "Louisville", population: "4.5 million", area: "40,409 sq mi"),
        States(name: "Louisiana", abbreviation: "LA", flagImageName: "louisiana_flag", stateSealImageName: "louisiana_seal", capitalCity: "Baton Rouge", largestCity: "New Orleans", population: "4.6 million", area: "52,378 sq mi"),
        States(name: "Maine", abbreviation: "ME", flagImageName: "maine_flag", stateSealImageName: "maine_seal", capitalCity: "Augusta", largestCity: "Portland", population: "1.3 million", area: "35,385 sq mi"),
        States(name: "Maryland", abbreviation: "MD", flagImageName: "maryland_flag", stateSealImageName: "maryland_seal", capitalCity: "Annapolis", largestCity: "Baltimore", population: "6.2 million", area: "12,407 sq mi"),
        States(name: "Massachusetts", abbreviation: "MA", flagImageName: "massachusetts_flag", stateSealImageName: "massachusetts_seal", capitalCity: "Boston", largestCity: "Boston", population: "6.9 million", area: "10,565 sq mi"),
        States(name: "Michigan", abbreviation: "MI", flagImageName: "michigan_flag", stateSealImageName: "michigan_seal", capitalCity: "Lansing", largestCity: "Detroit", population: "10 million", area: "96,716 sq mi"),
        States(name: "Minnesota", abbreviation: "MN", flagImageName: "minnesota_flag", stateSealImageName: "minnesota_seal", capitalCity: "St. Paul", largestCity: "Minneapolis", population: "5.7 million", area: "86,936 sq mi"),
        States(name: "Mississippi", abbreviation: "MS", flagImageName: "mississippi_flag", stateSealImageName: "mississippi_seal", capitalCity: "Jackson", largestCity: "Jackson", population: "2.9 million", area: "48,430 sq mi"),
        States(name: "Missouri", abbreviation: "MO", flagImageName: "missouri_flag", stateSealImageName: "missouri_seal", capitalCity: "Jefferson City", largestCity: "Kansas City", population: "6.1 million", area: "69,709 sq mi")
        // Add more states here...
    ]
    
    @StateObject private var mapState = MapState()

    var filteredStates: [States] {
        if searchState.searchText.isEmpty {
            return states
        } else {
            return states.filter { $0.name.localizedCaseInsensitiveContains(searchState.searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchState.searchText)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                List(filteredStates) { state in
                    NavigationLink(destination: StateDetailView(state: state)) {
                        HStack {
                            Image(state.flagImageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            Text(state.name)
                                .lineLimit(2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 25))
                        }
                    }
                }
            }
            .navigationTitle("US States")
        }
    }
}

struct StateDetailView: View {
    let state: States
    @StateObject private var animationState = ImageAnimationState()
    @StateObject private var mapState = MapState()
    @State var showingMap = false
    @State private var searchQuery = ""

    var body: some View {
        VStack(spacing: 20) {
            Image(state.flagImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(animationState.isFlagImageVisible ? 1 : 0)
                .onAppear {
                    withAnimation {
                        animationState.isFlagImageVisible = true
                    }
                }

            Image(state.stateSealImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: animationState.isSealImageVisible ? 0 : -UIScreen.main.bounds.width)
                .onAppear {
                    withAnimation {
                        animationState.isSealImageVisible = true
                    }
                }

            Button(action: {
                showingMap = true
                mapState.showMap = true
            }) {
                Text("Map")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.opacity(0.7))
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showingMap) {
                NavigationView {
                    VStack {
                        MapView(state: state, showingMap: $showingMap)

                        HStack {
                            TextField("Search", text: $searchQuery)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)

                            Button(action: {
                                // Clear existing annotations
                                // and perform search for the given query
                                showingMap = false
                                showingMap = true
                            }) {
                                Text("Search")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
                    .navigationBarTitle("Map", displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        showingMap = false
                    }) {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .padding()
                    })
                }
            }
            
            Text("State: \(state.name) (\(state.abbreviation))")
                .font(.title)

            Text("Capital City: \(state.capitalCity)")
            Text("Largest City: \(state.largestCity)")
            Text("Population: \(state.population)")
            Text("Area: \(state.area)")

            Spacer()
        }
        .padding()
        .navigationTitle(state.name)
    }
}


struct AboutYouView: View {
    var body: some View {
        Text("About Me: Hi, I'm Nikhil Krishnaswamy, a 9th-grader with a passion for photography and artificial intelligence (AI). I created an app that allows users to learn and memorize facts about the United States. I worked alone on this project and all images are from Wikipedia.")
            .padding(.all)
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            StateListView()
                .tabItem {
                    Label("States", systemImage: "list.bullet")
                }
            
            AboutYouView()
                .tabItem {
                    Label("About Me", systemImage: "person.fill.questionmark")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MapView: UIViewRepresentable {
    let state: States
    @Binding var showingMap: Bool
    @State private var searchQuery = ""

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(state.capitalCity) { placemarks, error in
            if let placemark = placemarks?.first,
               let coordinate = placemark.location?.coordinate {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = placemark.locality
                mapView.addAnnotation(annotation)
                
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
                mapView.setRegion(region, animated: true)
            }
        }
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        // Remove existing annotations (except for the capital city)
        let annotationsToRemove = view.annotations.filter { annotation in
            return !(annotation is MKUserLocation) && annotation.title != state.capitalCity
        }
        view.removeAnnotations(annotationsToRemove)
        
        // Perform search if a query is provided
        if !searchQuery.isEmpty {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = "\(searchQuery) \(state.capitalCity)"
            
            let search = MKLocalSearch(request: searchRequest)
            search.start { response, error in
                guard let mapItems = response?.mapItems else {
                    if let error = error {
                        print("Search error: \(error.localizedDescription)")
                    }
                    return
                }
                
                // Add annotations for search results
                for mapItem in mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = mapItem.placemark.coordinate
                    annotation.title = mapItem.name
                    view.addAnnotation(annotation)
                }
            }
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            return nil
        }
    }
}
