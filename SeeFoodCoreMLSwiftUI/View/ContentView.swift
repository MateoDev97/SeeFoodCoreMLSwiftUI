//
//  ContentView.swift
//  SeeFoodCoreMLSwiftUI
//
//  Created by Brian Ortiz on 2023-05-26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
        
    var body: some View {
        
        
        NavigationStack {
            VStack(spacing: 0) {
                
                HStack {

                    Button {
                        
                    } label: {
                    }.padding(.trailing, 20)
                        .padding(.leading, 20)
                    Text(viewModel.titleNavigationBar)
                        .frame(maxWidth: .infinity)
                    Button {
                        viewModel.isImagePickerPresented = true
                    } label: {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }.padding(.trailing, 20)
                    
                }.frame(height: 44)
                    .background(viewModel.navigationBarColor)
                
                if let image = viewModel.imageSelected {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 30)
                }
                
                Spacer()
                
            }
            .toolbar(.hidden, for: .navigationBar)
            
            .sheet(isPresented: $viewModel.isImagePickerPresented) {
                CustomImagePickerView(uiImage: $viewModel.imageSelected, isPresented: $viewModel.isImagePickerPresented)
            }
            .onChange(of: viewModel.imageSelected ?? UIImage()) {
                viewModel.imageChanged(image: $0)
            }
            
        }
            

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
