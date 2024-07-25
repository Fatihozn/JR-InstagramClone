//
//  FriendsPage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 25.07.2024.
//

import SwiftUI
import Combine

struct FriendsPage: View {
    @State private var progress: CGFloat = 0.0
    private let totalTime: CGFloat = 10.0 // Progress bar'ın tamamen dolacağı süre (saniye)
    @State private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    @State private var cancellable: Cancellable?
    @State private var isPaused = false

    var body: some View {
        VStack {
            ProgressView(value: round(progress * 100) / 100, total: totalTime)
                .frame(width: 200)
                .progressViewStyle(LinearProgressViewStyle(tint: .white))
                .onReceive(timer ?? Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()) { _ in
                    if !isPaused && progress < totalTime {
                        progress += 0.05
                    } else if progress >= totalTime {
                        pauseTimer()
                    }
                }
//                .onLongPressGesture(minimumDuration: 0.1) {
//                    pauseTimer()
//                }
//                .onTapGesture {
//                    resumeTimer()
//                }
                .padding()
            
            HStack {
                Button {
                    startTimer()
                } label: {
                    Text("Start")
                }
                
                Button {
                    pauseTimer()
                } label: {
                    Text("Pause")
                }
                
                Button {
                    resumeTimer()
                } label: {
                    Text("Resume")
                }
            }
        }
        .background(Color.black)
//        .onAppear {
//            startTimer()
//        }
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
//    FriendsPage()
//}
