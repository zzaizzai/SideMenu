//
//  SideMenu.swift
//  SideMenu
//
//  Created by 小暮準才 on 2022/09/07.
//

import SwiftUI
import SDWebImageSwiftUI

struct SideMenu: View {
    
    @Binding var showMenu : Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            
            VStack(alignment: .leading, spacing: 10) {
                
                
                WebImage(url: URL(string: "https://picsum.photos/id/237/200/300"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                Text("James")
                    .font(.title2.bold())
                
                Text("@jamesbond")
                    .font(.callout)
            }
            .padding(.horizontal)
            
            
            ScrollView{
                VStack(alignment: .leading, spacing: 35) {
                    
                    TabButton(title: "profile", image: "person")
                    TabButton(title: "Lists", image: "list.bullet.rectangle.portrait")
                    TabButton(title: "Bookmarks", image: "bookmark")
                    
                }
                .padding()
                .padding(.top, 30)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: getRect().width - 90)
        .frame(maxHeight: .infinity)
        .background(Color.primary.opacity(0.04).ignoresSafeArea(.container, edges: .vertical))
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    @ViewBuilder
    func TabButton(title: String, image: String) -> some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22, height: 22)
                
                
                Text(title)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }

    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
       MainView(showMenu: true)
    }
}


extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
