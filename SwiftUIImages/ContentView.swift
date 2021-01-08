//
//  ContentView.swift
//  SwiftUIImages
//
//  Created by admin on 25/09/2020.

import SwiftUI

// Struct kan ikke ændres umiddelbart, men man kan bruge @State til at man godt må ændre det alligevel.
// Man kan ikke lave en reference af en Struct
// Class kan ændre sig fra alle mulige steder, men man kan bruge private osv. for at lukke af for omverden
struct ContentView: View
{
    // @State kan ændre alle GUI's - hvis den ikke er givet en værdi her, skal den have en constructor
    @State var isPresented: Bool = false
    // Container for det billede der har været ændret i childklassen
    @State var inputImage: UIImage?
    
    // Skal være af typen Image som swift kan vise
    @State var imageToDisplay: Image = Image(systemName: "phone")
    
    // I ældre Xcode skal man have self foran alle isPresented og handleImage, men i nyeste XCode er det vist ikke nødvendigt
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                self.imageToDisplay
                    .resizable()
                    .frame(width: 250, height: 250, alignment: .center)
                
                Button( action:
                {
                    isPresented = true
                    
                }, label:
                {
                    Text("Hent billede")
                })
            }
        }
        // sheet kan enten vise eller skjule et view. $ dollertegn indikere at man løbende lytter til variablen for ændring. onDismiss skal metoden ikke have paranteser, da den bare får at vide at her er en metode, som du kan bruge når du har lyst
        // Man kan have så mange sheets som man ønsker
        .sheet(isPresented: $isPresented, onDismiss: handleImage, content:
        {
            MyImagePicker(image: $inputImage, isPresented: $isPresented)
        })
    }
    
    
    func handleImage()
    {
        if let imageFromMyImagePicker = inputImage
        {
            // opretter et Image ud fra UIImage, og gemmer det i variablen imageToDisplay
            self.imageToDisplay = Image(uiImage: imageFromMyImagePicker)
            print("Fandt billede")
        }
        else
        {
            print("Fandt intet billede i biblioteket")
        }
    }
}
