//
//  File.swift
//  LoktantramMeetup
//
//  Created by Loktantram on 29/07/23.
//

import Foundation
import SwiftUI

public struct InitialsUI<Content: View>: View {
    
    @Binding var text: String
    var fontWeight: Font.Weight = .regular
    var foregroundColor: Color?
    
    let background: Content
    
    //"~~~_2@1"
    // .whitespaces
    
    var initials: String {
        
        var nameItems = text.components(separatedBy: .whitespaces)
        if nameItems.count > 2 {
               nameItems = [nameItems[0],nameItems[1]]
        }
        
        return nameItems
            .filter { !$0.isEmpty }
            .reduce("") { partialResult, word in
                partialResult + String(word.first!.uppercased())
        }
    }
    
    /// Initializes a InitialsUI View from the first letter of every word from a string
    ///
    /// ```swift
    /// Initials(text: .constant("John Doe"), useDefaultForegroundColor: true, fontWeight: .medium) { Color.black } // Displays a View with a white medium weight JD and black background
    /// ```
    ///
    /// - Parameter text: The text used to create the initials
    /// - Parameter useDefaultForegroundColor: Use the default color white for the initials
    /// - Parameter fontWeight: The font weight used on the initials
    /// - Parameter background: Any view as the background
    ///
    /// - Returns: A view with the initials from provided the string
    public init(text: Binding<String>,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil,
                @ViewBuilder background: @escaping () -> Content) {
        self.background = background()
        self._text = text
        self.foregroundColor = useDefaultForegroundColor ? .white : .none
        if let weight = fontWeight {
            self.fontWeight = weight
        }
    }
    
    public var body: some View {
        GeometryReader { g in
            ZStack(alignment: .center) {
                background
                
                Text(initials)
                    .foregroundColor(foregroundColor)
                    .font(.system(size: g.size.width * 0.8))
                    .fontWeight(fontWeight)
                    .modifier(FitToWidth())
                    .padding(g.size.width * 0.18)
//                    .padding(calculatePadding(width: g.size.width))
            }
        }
    }
    
    private func calculatePadding(width: CGFloat) -> CGFloat {
        if (width <= 50 && initials.count > 1) {
            return 2
        }
        
        if (width <= 100) {
            return 5
        }
        
        return 20
    }
}

extension InitialsUI {
    /// Initializes a InitialsUI View from the provided initials
    ///
    /// ```swift
    /// Initials(initials: "John Doe", useDefaultForegroundColor: true, fontWeight: .medium) { Color.black } // Displays a View with a white medium weight JD and black background
    /// ```
    ///
    /// - Parameter initials: The initials
    /// - Parameter useDefaultForegroundColor: Use the default color white for the initials
    /// - Parameter fontWeight: The font weight used on the initials
    /// - Parameter background: Any view as the background
    ///
    /// - Returns: A view with the provided initials
    public init(initials: String,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil,
                @ViewBuilder background: @escaping () -> Content) {
        let text = initials.map { "\($0)" }.joined(separator: " ")
        
        self.init(text: .constant(text),
                  useDefaultForegroundColor: useDefaultForegroundColor,
                  fontWeight: fontWeight,
                  background: background)
    }
}

extension InitialsUI where Content == Color {
    /// Initializes a InitialsUI View with a random background color using the first letter of every word from a string
    ///
    /// ```swift
    /// Initials(text: .constant("John Doe"), useDefaultForegroundColor: true, fontWeight: .medium, randomBackground: true) // Displays a View with a white medium weight JD and a random background
    /// ```
    ///
    /// - Parameter text: The text used to create the initials
    /// - Parameter useDefaultForegroundColor: Use the default color white for the initials
    /// - Parameter fontWeight: The font weight used on the initials
    /// - Parameter randomBackground: Use a random background
    ///
    /// - Returns: A view with the initials from provided the string
    ///
    /// - warning: If you don't want to use random backgrounds, use a different initializer!
    public init(text: Binding<String>,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil,
                randomBackground: Bool) {
        self.init(text: text,
                  useDefaultForegroundColor: useDefaultForegroundColor,
                  fontWeight: fontWeight) {
            if randomBackground {
                return randomColor(for: text.wrappedValue)
            } else {
                return Color.gray
            }
        }
    }
    
    /// Initializes a InitialsUI View with a random background color using the provided initials
    ///
    /// ```swift
    /// Initials(initials: "JD", useDefaultForegroundColor: true, fontWeight: .medium, randomBackground: true) // Displays a View with a white medium weight JD and a random background
    /// ```
    ///
    /// - Parameter initials: The initials
    /// - Parameter useDefaultForegroundColor: Use the default color white for the initials
    /// - Parameter fontWeight: The font weight used on the initials
    /// - Parameter randomBackground: Use a random background
    ///
    /// - Returns: A view with the initials from provided the initials
    ///
    /// - warning: If you don't want to use random backgrounds, use a different initializer!
    public init(initials: String,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil,
                randomBackground: Bool) {
        self.init(initials: initials,
                  useDefaultForegroundColor: useDefaultForegroundColor,
                  fontWeight: fontWeight) {
            if randomBackground {
                return randomColor(for: initials)
            } else {
                return Color.gray
            }
        }
    }
}

extension InitialsUI where Content == Color {
    /// Initializes a InitialsUI View from the first letter of every word from a string with gray background
    ///
    /// ```swift
    /// Initials(text: .constant("John Doe"), useDefaultForegroundColor: true, fontWeight: .medium) // Displays a View with a white medium weight JD and gray background
    /// ```
    ///
    /// - Parameter text: The text used to create the initials
    /// - Parameter useDefaultForegroundColor: Use the default color white for the initials
    /// - Parameter fontWeight: The font weight used on the initials
    ///
    /// - Returns: A view with the initials from provided the string
    ///
    /// - Warning: This initializer applies a gray background color by default!
    public init(text: Binding<String>,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil) {
        self.init(text: text,
                  useDefaultForegroundColor: useDefaultForegroundColor,
                  fontWeight: fontWeight) {
            Color.gray
        }
    }
    
    /// Initializes a InitialsUI View from the provided initials with gray background
    ///
    /// ```swift
    /// Initials(initials: "JD", useDefaultForegroundColor: true, fontWeight: .medium) // Displays a View with a white medium weight JD and gray background
    /// ```
    ///
    /// - Parameter initials: The initials
    /// - Parameter useDefaultForegroundColor: Use the default color white for the initials
    /// - Parameter fontWeight: The font weight used on the initials
    ///
    /// - Returns: A view with the initials from provided the string
    ///
    /// - Warning: This initializer applies a gray background color by default!
    public init(initials: String,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil) {
        self.init(initials: initials,
                  useDefaultForegroundColor: useDefaultForegroundColor,
                  fontWeight: fontWeight) {
            Color.gray
        }
    }
}

struct FitToWidth: ViewModifier {
    var fraction: CGFloat = 1.0
    func body(content: Content) -> some View {
        GeometryReader { g in
            VStack {
                //Spacer()
                content
                    .font(.system(size: 1000))
                    .minimumScaleFactor(0.005)
                    .lineLimit(1)
                    .frame(width: g.size.width * self.fraction, height: g.size.width * self.fraction)
               // Spacer()
            }
        }
    }
}



// MARK: Color randomization methods

func randomColorComponent() -> Int {
    let limit = 214 - 30
    return 30 + Int(drand48() * Double(limit))
}

func randomColor(for string: String) -> Color {
    srand48(string.hashValue)

    let red = CGFloat(randomColorComponent()) / 255.0
    let green = CGFloat(randomColorComponent()) / 255.0
    let blue = CGFloat(randomColorComponent()) / 255.0
    
    return Color(red: red, green: green, blue: blue)
}
