//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Rishav Gupta on 05/07/23.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Local center \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                        print("Custom center \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                    }
            }
            .background(.orange)
            
            Text("Right")
        }
    }
}

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
//        HStack(alignment: .lastTextBaseline) {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
        
//        VStack {
//            GeometryReader { geo in // geo contains the parents proposed size
//                Text("Hello world")
//                    .frame(width: geo.size.width * 0.9)
//                    .background(.red)
//            }
//            .background(.green)
//            
//            Text("More text")
//                .background(.blue)
//        }
        
//        OuterView()
//            .background(.red)
//            .coordinateSpace(name: "Custom")
        
        GeometryReader { fullView in
            ZStack {
                ScrollView {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .scrollTransition { content, phase in
                                    content
                                        .hueRotation(.degrees(45 * phase.value))
                                }
                                .background(Color(hue: geo.frame(in: .global).maxY / fullView.size.height, saturation: 1, brightness: 1))
                                .rotation3DEffect(
                                    .degrees(geo.frame(in: .global).minY - fullView.size.height / 2 ) / 5,  axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                                .scaleEffect(CGSize(width: geo.frame(in: .global).maxY / geo.size.width, height: 1.0))
                        }
                        .frame(height: 40)
                    }
                }
                
                LinearGradient(stops: [
                    .init(color: Color(UIColor.black).opacity(0.01), location: 0),
                    .init(color: Color(UIColor.black), location: 1)
                ], startPoint: .bottom, endPoint: .top
                )
                .allowsHitTesting(false)
                .frame(height: 400)
                .offset(CGSize(width: 0, height: -fullView.frame(in: .global).minY - 200))
            }
        }
        
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(1..<20) { num in
//                    GeometryReader { geo in
//                        Text("Number \(num)")
//                            .font(.largeTitle)
//                            .padding()
//                            .background(.red)
//                            .rotation3DEffect(
//                                .degrees(-geo.frame(in: .global).minX / 8),
//                                                      axis: (x: 0.0, y: 1.0, z: 0.0)
//                            )
//                            .frame(width: 200, height: 200)
//                    }
//                    .frame(width: 200, height: 200)
//                }
//            }
//        }
    }
}

#Preview {
    ContentView()
}
