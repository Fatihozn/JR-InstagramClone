//
//  StoryPage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 24.07.2024.
//

import SwiftUI
import Combine


struct StoryPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var progress: CGFloat = 0.0
    private let totalTime: CGFloat = 10.0 // Progress bar'ın tamamen dolacağı süre (saniye)
    @State private var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State private var cancellable: Cancellable?
    @State private var isPaused = false
    
    @State var message: String = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                
                VStack {
                    
                    VStack {
                        ProgressView(value: round(progress * 100) / 100, total: totalTime)
                            .frame(width: width)
                            .progressViewStyle(LinearProgressViewStyle(tint: .white))
                            .onReceive(timer) { _ in
                                if progress < totalTime {
                                    progress += 0.05
                                } else {
                                    print(progress)
                                    print(totalTime)
                                    timer.upstream.connect().cancel() // Timer'ı durdur/
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        
                        HStack {
                            HStack {
                                StoryItemCard(size: width / 8, isOnStory: true)
                                
                                Text("Kullanıcı adı")
                            }
                            
                            Spacer()
                            
                            HStack {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .font(.title)
                                }
                                .padding(.horizontal, 3)
                                
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(systemName: "xmark")
                                        .font(.title)
                                }
                                .padding(.horizontal, 3)
                            }
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        TextField("Mesaj gönder", text: $message)
                            .padding(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(0.8), lineWidth: 2)
                            )
                            .padding(.horizontal, 5)
                            .foregroundStyle(.white)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: width / 12, height: width / 12)
                        }
                        .padding(.horizontal, 5)
                        
                        Button {
                            
                        } label: {
                            Image("send")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: width / 12, height: width / 12)
                        }
                        .padding(.horizontal, 5)
                    }
                    
                }
                .onAppear {
                   
                }
                .onDisappear {
                    timer.upstream.connect().cancel()
                }
                .tint(.white)
                .navigationBarBackButtonHidden(true)
                
            }
        }
        
    }
    
}

//#Preview {
//    StoryPage()
//}
//
//
