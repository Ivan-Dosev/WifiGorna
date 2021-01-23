//
//  FirstView.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 17.01.21.
//

import SwiftUI


struct FirstView: View {
    
 
    @State var image        : Image?
    @State var showingImage : Bool = false
    @State var inportImage  : UIImage?


    @Environment(\.managedObjectContext) var moc

    @State var isView     : Bool   = false
    @State var isSend     : Bool   = false
    @State var isImage    : Bool   = false
//    @State var imageView  : String = "fierstLogo"
    @State var imageView  : String = "Ok"
    var body: some View {
     
        
        ZStack {
            Color.gray.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                
                VStack{
                    if image != nil {
                       image?
                         .resizable()
                         .scaleEffect()
                         .cornerRadius(15)
                         .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height / 2, alignment: .center)
                    }else{
                        ZStack {
                            Text("Tap to select \na picture")
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                                .foregroundColor(Color.gray)
                                .offset(x: -50 , y: 140)
                            Image("Ok")
                                .resizable()
                                .scaleEffect()
                                .cornerRadius(15)
                        }
                    }
                }
                .onTapGesture {
                           self.showingImage = true
                }
                .sheet(isPresented: $showingImage, onDismiss: loadImage) { ImagePicker(image: $inportImage)}
                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 1.8)
                .modifier(PrimaryButton())



                    
                Spacer()
                VStack( spacing: 50) {
                    
                    if inportImage != nil {
                        Button(action: {
                            self.isSend.toggle()
                        }) {
                            Text("Send Scypto Data")
                                .font(.system(size: 27))
                                .frame(width: UIScreen.main.bounds.width / 1.2 , height: 100)
                                .modifier(PrimaryButton())
                             
                        }
                        .sheet(isPresented: self.$isSend, onDismiss: loadImage) { SendView(image: $inportImage) }
                    }

                    
                    Button(action: {
                        self.isView.toggle()
                    }) {
                        Text("View Data")
                            .font(.system(size: 27))
                            .frame(width: UIScreen.main.bounds.width / 1.2  , height: 100)
                            .modifier(PrimaryButton())
                         
                    }
                    .sheet(isPresented: self.$isView, onDismiss: loadImage) { DataView(image: $inportImage).environment(\.managedObjectContext , moc)}

                }
            }
        }
        .onAppear(){
            inportImage = UIImage(named: "Ok")
  
        }
    }
    
    func loadImage() {
        guard let inportImage = inportImage else {return}
            image = Image(uiImage: inportImage)
    }
    
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
//        FirstView()
        Text("")
    }
}
