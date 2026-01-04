//
//  ContentView.swift
//  MediaInSwiftUI
//
//  Created by Neosoft on 02/01/26.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
//    @State private var selected: PhotosPickerItem?
//    @State private var picture: UIImage?
    @State private var path = NavigationPath()
    @State private var picture: UIImage?
    @State private var showAlert: Bool = false
    
    var body: some View {
//        NavigationStack {
//            VStack {
//                Image(uiImage: (picture ?? UIImage(named: "noImage"))!)
//                    .resizable()
//                    .scaledToFit()
//                Spacer()
//                PhotosPicker(selection: $selected, matching: .images,photoLibrary: .shared()) {
//                    Text("Select a photo")
//                        .padding()
//                        .buttonStyle(.borderedProminent)
//                }
//            }
//            .onChange(of: selected, initial: false) { oldValue, newValue in
//                Task(priority: .background) {
//                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
//                        picture = UIImage(data: data)
//                    }
//                }
//            }
//        }
        
//        Open Camera
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    Button("Share Picture") {
                        showAlert = true
                    }.disabled(picture == nil ? true : false)
                    Spacer()
                    NavigationLink("Get Picture", value: "Open picture")
                }.navigationDestination(for: String.self) { _ in
                    ImagePicker(path: $path, picture: $picture)
                }
                .alert("Save Picture", isPresented: $showAlert) {
                    Button("Cancel", role: .cancel) {
                        showAlert = false
                    }
                    Button("Yes", role: .none) {
                        if let picture {
                            UIImageWriteToSavedPhotosAlbum(picture, nil, nil, nil)
                        }
                    }
                } message: {
                    Text("Do you want to store the picture in photos library?")
                }

                Image(uiImage: (picture ?? UIImage(named: "noImage"))!)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                Spacer()
            }.padding()
        }.statusBarHidden()
        
    }
}

#Preview {
    ContentView()
}
