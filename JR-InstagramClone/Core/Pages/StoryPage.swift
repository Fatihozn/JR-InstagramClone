//
//  StoryPage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 24.07.2024.
//

import SwiftUI
import Combine
import Kingfisher

struct StoryPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = StoryViewModel()
    @EnvironmentObject var globalClass: GlobalClass
    
    @State var user: User?
    
    @State var filtredList: [Story] = []
    
    @State private var progress: CGFloat = 0.0
    private let totalTime: CGFloat = 10.0 // Progress bar'ın tamamen dolacağı süre (saniye)
    @State private var timer : Publishers.Autoconnect<Timer.TimerPublisher>?
    @State private var cancellable: Cancellable?
    @State private var isPaused = false
    
    @State var message: String = ""
    
    @State private var isProfilePageActive = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                
                VStack {
                    
                    VStack {
                        ProgressView(value: round(progress * 100) / 100, total: totalTime)
                            .padding(.top)
                            .progressViewStyle(LinearProgressViewStyle(tint: .white))
                            .onReceive(timer ?? Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()) { _ in
                                if !isPaused && progress < totalTime {
                                    progress += 0.05
                                } else if progress >= totalTime {
                                    pauseTimer() // Timer'ı durdur/
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        
                        HStack {
                            HStack {
                                StoryItemCard(user: user, size: width / 8, isOnStory: true, isProfilePageActive: $isProfilePageActive)
                                
                                Text(user?.username ?? "")
                                    .fontWeight(.bold)
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
                    .padding(.horizontal, 10)
                    .frame(width: width)
                    
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
                    .padding(.bottom)
                    .padding(.horizontal, 10)
                    .frame(width: width)
                    
                }
                .background(
                    KFImage(URL(string: filtredList.first?.photoUrl ?? ""))
                    .resizable()
                    .frame(width: width)
                    .scaledToFit()
                    
                )
                .tint(.white)
                .navigationBarBackButtonHidden(true)
                
            }
        }
        .onAppear {
            if let filtred = user?.stories?.filter({ $0.timestamp.hourDiffrence() != "eski" }) {
                filtredList = filtred // bu liste eski hikayeleri ayırt edecek yenileri ekrana basacak
                
                viewModel.updateStory(userId: user?.id ?? "", storyId: filtred.first?.id ?? "", oldSeenBy: filtred.first?.seenBy ?? [], mainUserId: globalClass.User?.id ?? "") { isUpdated in
                    if isUpdated {
                        viewModel.getUserInfos(userId: user?.id ?? "") { user in
                            self.user?.stories = user?.stories
                            globalClass.updatedMainUser(id: "")
                        }
                    }
                }
                
            }
            
        }
        .onChange(of: isProfilePageActive) { newValue, _ in
            if !newValue {
                pauseTimer()
            } else {
                resumeTimer()
            }
            
        }
        
    }
    
    
    private func startTimer() {
        timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
        cancellable = timer?.sink { _ in
            if !isPaused && progress < totalTime {
                progress += 0.05
            } else if progress >= totalTime {
                pauseTimer()
            }
        }
    }
    
    private func pauseTimer() {
        cancellable?.cancel()
        isPaused = true
    }
    
    private func resumeTimer() {
        isPaused = false
        startTimer()
    }
    
}

//#Preview {
//    StoryPage()
//}
//
//
