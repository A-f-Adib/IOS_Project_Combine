//
//  HapticEffect.swift
//  new.SwT
//
//  Created by A.f. Adib on 1/24/24.
//

import CoreHaptics
import SwiftUI

struct HapticEffect: View {
    @State private var engine : CHHapticEngine?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: complexSuccess)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics
        else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("error")
        }
    }
    
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics
        else { return }
        
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Error to play pattern")
        }
        
    }
}

struct HapticEffect_Previews: PreviewProvider {
    static var previews: some View {
        HapticEffect()
    }
}
