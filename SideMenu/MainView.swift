//
//  MainView.swift
//  SideMenu
//
//  Created by 小暮準才 on 2022/09/07.
//

import SwiftUI

struct MainView: View {
    @State var showMenu: Bool = false
    
    
    @State var offset : CGFloat = 0
    
    @GestureState var gestureOffset : CGFloat  = 0
    
    
    var body: some View {
        
        let sideMenuWidth = getRect().width - 90
        
        NavigationView{
            HStack(spacing: 0){
                
                SideMenu(showMenu: self.$showMenu)
                
                VStack{
                    
                    Button {
                        withAnimation {
                            self.showMenu = true
                            offset = sideMenuWidth
                        }
                    } label: {
                        Text("showMenu")
                    }

                }
                .frame(maxHeight: .infinity)
                .frame(width: getRect().width)
                .overlay(Rectangle()
                    .fill(Color.primary.opacity(Double(offset/sideMenuWidth) / 5))
                    )
                .ignoresSafeArea()
                .onTapGesture {
                        showMenu = false
                        offset = 0
                }
                
            }
            .frame(width: getRect().width + sideMenuWidth )
            .offset(x: -(sideMenuWidth / 2))
            .offset(x: offset > 0 ? offset : 0)
            .gesture(DragGesture()
                .updating($gestureOffset, body: { value, out, _ in
                    out = value.translation.width
                }).onEnded(onEnd(value:))
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .animation(.easeOut, value: offset == 0 )
        .onChange(of: gestureOffset) { newValue in
            onChange()
        }
    }
    
    func onChange() {
        let sideBarWith = getRect().width - 90
        
        offset = (gestureOffset != 0) ? (gestureOffset < sideBarWith ? gestureOffset : offset) : offset
    }
    
    
    func onEnd(value: DragGesture.Value) {
        
        let sideBarWidth = getRect().width - 90
        
        let translation = value.translation.width
        
        withAnimation {
            if translation > 0 {
                if translation > (sideBarWidth / 2) {
                    offset = sideBarWidth
                    showMenu = true
                }
                else {
                    offset  = 0
                    showMenu = false
                }
            } else {
                if -translation > (sideBarWidth / 2) {
                    offset = 0
                    showMenu = false
                }
                else {
                    offset = sideBarWidth
                    showMenu = true
                }
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showMenu: false)
    }
}
