//
//  SwiftUIAnimation.swift
//  BackCAPS
//
//  Created by Zohaib Ahmed on 30/07/2024.
//
import SwiftUI

struct AnimationFile: View {
    
    @State
    var isLoading = false
    @State
    var runningOperation = false
    @State
    var done = false
    
    var body: some View {
        
        Button{
            runningOperation.toggle()
        }
        label: {
            if runningOperation && !done {
                Circle()
                    .trim(from: 0.0, to: 0.8)
                    .stroke(.white, lineWidth: 5)
                    .frame(width: 40)
                    .padding(.horizontal, 3)
                    .rotationEffect(.degrees(isLoading ? 360 : 0))
                    .animation(.linear(duration: 0.3).repeatForever(autoreverses: false), value: isLoading)
                    .onAppear{
                        isLoading = true
                    }
            }
            if runningOperation {
                    if !done {
                        Text("Processing")
                            .transition(.identity)
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                    withAnimation{
                                        isLoading = false
                                        done = true
                                    }
                                }
                            }
                    } else {
                        Text("Done")
                            .transition(.identity)
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    withAnimation{
                                        done = false
                                        runningOperation = false
                                    }
                                }
                            }
                    }
    
                } else {
                    Text("Submit")
                        .transition(.asymmetric(
                            insertion: .offset(x:0 ,y: -20)
                                        .combined(with: .opacity),
                            removal: .identity)
                        )
                }
        }
        .font(.system(.largeTitle, design: .rounded))
        .fontWeight(.bold)
        .buttonStyle(.borderedProminent)
        .controlSize(.extraLarge)
        .transition(.opacity)
        .tint(done ? .red : .green)
    }
}

#Preview {
    AnimationFile()
}
