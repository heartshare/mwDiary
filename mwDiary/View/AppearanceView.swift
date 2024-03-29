//
//  AppearanceView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/23.
//

import SwiftUI

struct AppearanceView: View {
    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @AppStorage("fontStyle") var fontStyleStr:FontType = .Default
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    @AppStorage("smallTitle") var smallTitle:Bool = false
    @AppStorage("cardLayout") var cardLayout:Int = 1
    @AppStorage("showMoodCard") var showMoodCard = false
    @EnvironmentObject var diaryvm:DiaryViewMode
    
    private let icons:[AppIcon] = [
        AppIcon(iconName: nil, logoName: "icon 1"),
        AppIcon(iconName: "AppIcon 2", logoName: "icon 2"),
        AppIcon(iconName: "AppIcon 3", logoName: "icon 3"),
        AppIcon(iconName: "AppIcon 4", logoName: "icon 4"),
        AppIcon(iconName: "AppIcon 5", logoName: "icon 5"),
    ]
    private let themes:[Theme] = [
        Theme(theme: .Automatic),
        Theme(theme: .Light),
        Theme(theme: .Dark)
        //        Theme(theme: .rainbow)
    ]
    public let fontstyles:[FontStyle]=[
        FontStyle(font: .Default),
        FontStyle(font: .SmileySans),
        FontStyle(font: .Mono)
    ]
    private let heartColors:[HeartColor] = [HeartColor(color: .primary),
                                            HeartColor(color: .yellow),
                                            HeartColor(color: .red),
                                            HeartColor(color: .blue),
                                            HeartColor(color: .cyan)
    ]
    
    
    var body: some View {
        List{
            Group{
                //MARK: - change Theme
                Section {
                    themesCell
                } header: {
                    Text("THEMES")
                }
                //MARK: - change font style
                Section{
                    fontStyleCell
                } header: {
                    Text("Font Style")
                }
                //MARK: - change app icon
                Section{
                    appIconCell
                } header: {
                    Text("APP ICON")
                }
            }
            Group{
                //MARK: - change favcolor
                Section{
                    favourateColorCell
                } header: {
                    Text("Favourite Color")
                }
                //MARK: - change LAYOUT
                Section{
                    layoutCell
                } header: {
                    Text("LAYOUT")
                }
                Section{
                    //MARK: - change small title
                    Toggle(isOn: $smallTitle) {
                        smallTitleCell
                    }
//                    Toggle(isOn: $showMoodCard) {
//                        moodCardCell
//                    }
                } header: {
                    Text("MORE")
                }
                Group{
                    Spacer()
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
        }//list
        .tint(appHeartColor.SwiftUiColor)
        .listStyle(.plain)
        .navigationTitle("Appearance")
    }
    
    
    //MARK: Componts
    var themesCell:some View{
        VStack(alignment:.leading,spacing: 0){
            ForEach(themes) { theme in
                HStack{
                    Label(theme.name, systemImage: theme.icon)
                        .labelStyle(.titleAndIcon)
                        .font(.headline)
                        .padding(.leading)
                    Spacer()
                    Image(systemName: "checkmark")
                        .opacity(appTheme == theme.theme ? 1 : 0)
                        .padding(.trailing)
                }
                .frame(height: 50)
                //用于点击
                .background(Color(.systemBackground).opacity(0.01))
                .onTapGesture {
                    withAnimation(.easeOut) {
                        appTheme = theme.theme
                    }
                }
            }
        }
    }
    var fontStyleCell:some View{
        ScrollView(.horizontal,showsIndicators:false){
            HStack(spacing:0){
                ForEach(fontstyles) { fs in
                    Button {
                        fontStyleStr = fs.font
                    } label: {
                        VStack(spacing: 8){
                            Text("Hell0你好")
                                .font(.custom(fs.fontName,size:18))
                                .foregroundColor(fontStyleStr == fs.font ? appHeartColor.SwiftUiColor : Color.primary)
                            Text(fs.name)
                                .foregroundColor(fontStyleStr == fs.font ? .primary:.gray)
                        }
                    }.frame(width:120,height:80)
                }
            }.padding(10)
        }
    }
    var appIconCell:some View{
        ScrollView(.horizontal){
            HStack{
                ForEach(icons){ icon in
                    Button {
                        UIApplication.shared.setAlternateIconName(icon.iconName)
                    } label: {
                        Image(icon.logoName)
                            .resizable()
                            .frame(width: 88, height: 88)
                            .cornerRadius(20)
                            .padding()
                    }
                }
            }
        }
    }
    var favourateColorCell:some View{
        ScrollView(.horizontal,showsIndicators:false){
            HStack(spacing:0){
                ForEach(heartColors){ item in
                    Button {
                        appHeartColor = item.color
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(item.color.SwiftUiColor)
                            .frame(width: 45, height: 45)
                            .cornerRadius(20)
                            .padding(.vertical)
                            .padding(.horizontal,15)
                            .overlay{
                                if item.color == appHeartColor {
                                    item.color.SwiftUiColor
                                        .frame(height:5)
                                        .frame(maxHeight:.infinity,alignment:.bottom)
                                }
                            }
                    }
                }
            }
        }
    }
    var layoutCell:some View{
        VStack(spacing:18){
            ForEach(1...6, id: \.self) { i in
                DiaryCardLayOutView(e_isFav:i == cardLayout ? true : false,layoutIndex:i,fontStyleString:fontStyleStr,settingView:true)
                    .onTapGesture {
                        cardLayout = i
                    }
            }
        }
    }
    var smallTitleCell:some View{
        VStack(alignment:.leading){
            Text("Small Title").font(.headline)
            Text("Title style above every page").font(.footnote).foregroundColor(.gray)
        }
    }
    var moodCardCell:some View{
        VStack(alignment:.leading){
            Text("Show Mood Card").font(.headline)
            Text("Mood Card in SettingView").font(.footnote).foregroundColor(.gray)
        }
    }
    
}//View




struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
            .environmentObject(DiaryViewMode())
            .preferredColorScheme(.light)
        
    }
}

