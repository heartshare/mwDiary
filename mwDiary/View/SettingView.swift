//
//  SettingView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/16.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    @AppStorage("smallTitle") var smallTitle:Bool = false
    @EnvironmentObject var diaryvm:DiaryViewMode
    
    @AppStorage("isICloud") var isICloud:Bool = true
    
    @AppStorage("defaultTitle") var defaultTitle = "My daily mood"
    @AppStorage("defaultBody") var defaultBody = ""
    @State var editTitle:String = ""
    @State var editText:String = ""
    
    var body: some View {
        //                kakeSettingView
        minimalSettingView
    }//body
    
    var minimalHelloCard:some View{
        VStack(alignment: .leading,spacing: 10){
            Text("Hello world~")
                .font(.title)
                .fontWeight(.semibold)
            Text("Write your diary here,make all things simple.")
                .lineLimit(2)
            Link(destination: URL(string: "mailto:wxmvv@outlook.com")!, label: {Text("Contact").foregroundColor(.blue)}
            )
        }
        .padding(18)
        .frame(width: 300)
        //        .background(.ultraThinMaterial)
        .background(content: {
            appHeartColor.SwiftUiColor.opacity(0.1)
        })
        .cornerRadius(10)
        
    }
    var minimalSettingView:some View{
        NavigationView {
            List{
                //                Spacer()
                //                    .listRowSeparator(.hidden)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        minimalHelloCard
                    }
                }
                .listRowSeparator(.hidden)
                Spacer()
                NavigationLink {
                    AppearanceView()
                } label: {
                    Text("Appearance")//外观风格
                }
                //                .listRowSeparator(.hidden)
                //                .listRowBackground(
                //                    Color(.gray).opacity(0.1)
                //                )
                
                Spacer()
                Button {
                    diaryvm.exportAllToCSV()
                } label: {
                    Text("Export Data")
                }
                //                .listRowBackground(
                //                    Color(.gray).opacity(0.1)
                //                )
                //                .listRowSeparator(.hidden)
                NavigationLink {
                    DefaultDiaryView(editTitle: $editTitle, editText: $editText)
                } label: {
                    Text("Default Diary")
                }.onAppear {
                    if defaultTitle != "My daily mood" && defaultTitle != "" {
                        editTitle = defaultTitle
                    }
                    if defaultBody != "" {
                        editText = defaultBody
                    }
                }
                //                .listRowBackground(
                //                    Color(.gray).opacity(0.1)
                //                )
                //                .listRowSeparator(.hidden)
                Spacer()
                Link(destination: URL(string: "mailto:wxmvv@outlook.com")!, label: {Text("Contact")})
                //                    .listRowBackground(
                //                        Color(.gray).opacity(0.1)
                //                    )
                //                    .listRowSeparator(.hidden)
                
            }
            //            .listStyle(.plain)
            .listStyle(.inset)
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(smallTitle ? .inline:.large)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
    
    var kakeSettingView:some View{
        NavigationView {
            List{
                Section{
                    NavigationLink {
                        AppearanceView()
                    } label: {
                        Label("Appearance", systemImage: "paintpalette.fill")
                            .font(.subheadline)
                            .frame(height: 33)
                        
                    }
                    
                    Button {
                        diaryvm.exportAllToCSV()
                    } label: {
                        Label("Export Data", systemImage: "doc.circle.fill")
                            .font(.subheadline)
                            .frame(height: 33)
                    }
                    
                    //TODO: - icloud
                    //                        Toggle(isOn: $isICloud) {
                    //                            Label("iCloud Sync", systemImage: "icloud.circle.fill")
                    //                                .font(.subheadline)
                    //                                .frame(height: 33)
                    //                        }
                    //                        .tint(appHeartColor.SwiftUiColor)
                    
                    
                } header:{
                    Text("GENERAL")
                }
                
                //TODO: - 内购
                //                    Section{
                //                        Label("Premium Features", systemImage: "crown")
                //                    } header:{
                //                    Text("PREMIUM")
                //                }
                
                
                //MARK: - defaultTitle
                Section {
                    NavigationLink {
                        DefaultDiaryView(editTitle: $editTitle, editText: $editText)
                    } label: {
                        Label("Default Diary", systemImage: "doc.text")
                            .font(.subheadline)
                            .frame(height: 33)
                        //                            .onTapGesture {
                        //
                        //                            }
                    }.onAppear {
                        if defaultTitle != "My daily mood" && defaultTitle != "" {
                            editTitle = defaultTitle
                        }
                        if defaultBody != "" {
                            editText = defaultBody
                        }
                    }
                } header: {
                    Text("TEMPLATE")
                }
                
                
                Section{
                    Link(destination: URL(string: "mailto:wxmvv@outlook.com")!, label: {Label("Contact", systemImage: "link.circle.fill")})
                        .font(.subheadline)
                        .frame(height: 40)
                    //TODO: - 分享和评论 内购
                    //                        Link(destination: URL(string: "http://itunes.apple.com/cn/app/id6443545292")!, label: {Label("Rate App", systemImage: "star")})
                    //                        //http://itunes.apple.com/cn/app/id6443545292
                    //                        //https://itunes.apple.com/cn/app/id6443545292
                    //                        Label("Share", systemImage: "square.and.arrow.up")
                    //                        Label("Buy me a Coffee", systemImage: "cup.and.saucer")
                } header:{
                    Text("OTHERS")
                }
                
            }//list
            
            .tint(Color(.label))
            .labelStyle(.titleAndIcon)
            .listStyle(.plain)
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
            
        }//nav
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    
}






struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
        //            .preferredColorScheme(.dark)
    }
}



