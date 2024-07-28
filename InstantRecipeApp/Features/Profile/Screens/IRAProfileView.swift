//
//  IRAProfileView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 27/02/2024.
//

import SwiftUI
import LinkNavigator

struct IRAProfileView: View {
    let navigator: LinkNavigatorType
    @State private var selectedTab = 0
    let tabItems = ["Recipes", "Liked"]
    @StateObject var authViewModel: IRAAuthViewModel
    @StateObject var profileViewModel: IRAProfileViewModel
    
    // AppStorage property to keep appwrite session id
    @AppStorage("appwriteSessionID") var appwriteSessionID: String = ""
    
    init(navigator: LinkNavigatorType) {
        self._authViewModel = StateObject(wrappedValue: IRAAuthViewModel())
        self._profileViewModel = StateObject(wrappedValue: IRAProfileViewModel())
        self.navigator = navigator
    }
    
    @State private var showAlert = false
    
    var body: some View {
        if profileViewModel.profileState == .loading {
            HStack {
                Text("Loading profile ...")
            }
        }
        
        if profileViewModel.profileState == .error {
            HStack {
                Text("Error getting profile ...")
                Button {
                    appwriteSessionID = ""
                    navigator.replace(paths: ["signIn"], items: [:], isAnimated: true)
                } label: {
                    Text("Force Log Out")
                }

            }
        }
        
        if profileViewModel.profileState == .success {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    //                        IRAProfileImageView(imageUrl: "https://avatars.githubusercontent.com/u/30414962?v=4")
                    //                            .padding(.bottom, 16)
                    Text(profileViewModel.userDetail?.name ?? "Profile Name")
                        .font(.system(size: 16))
                        .foregroundColor(Color(UIColor(hex: "#3E5481")))
                        .fontWeight(.bold)
                        .padding(.bottom, 2)
                    HStack(alignment: .center) {
                        Text(profileViewModel.userDetail?.emailAddress ?? "@")
                            .font(.system(size: 12))
                            .foregroundColor(Color(UIColor(hex: "#3E5481")))
                            .fontWeight(.semibold)
                        
                        if let isVerified = profileViewModel.userDetail?.emailAddressVerified {
                            Image(systemName: isVerified ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .font(.caption)
                                .foregroundColor(.white)
                                .background(isVerified ? Color.green : Color.gray)
                                .clipShape(Circle())
                                .padding(.horizontal, 2)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .font(.caption)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .clipShape(Circle())
                                .padding(.horizontal, 2)
                        }
                    }.padding(.bottom, 2)
                    if let registrationDateString = profileViewModel.userDetail?.registrationDateTime,
                       let registrationDate = customStringToDate(registrationDateString) {
                        Text("Member since: \(formattedDate(registrationDate))")
                            .font(.system(size: 10))
                            .foregroundColor(Color(UIColor(hex: "#3E5481")))
                            .fontWeight(.bold)
                            .padding(.bottom, 12)
                    } else {
                        Text("Member since: N/A")
                            .font(.system(size: 10))
                            .foregroundColor(Color(UIColor(hex: "#3E5481")))
                            .fontWeight(.bold)
                            .padding(.bottom, 12)
                    }
                    Rectangle()
                        .frame(height: 8)
                        .foregroundColor(Color(UIColor(hex: "#F4F5F7")))
                        .padding(.bottom, 8)
                    
                    TabBarView(currentTab: $selectedTab)
                    
                    TabView(selection: $selectedTab) {
                        ScrollView {
                            LazyVGrid(columns: Array(repeating: GridItem(spacing: 24), count: 2)) {
                                ForEach(1...8, id: \.self) { item in
                                    IRARecipeItemView(
                                        recipeImageId: "",
                                        foodName: "Food Name",
                                        foodCategory: "Food Details",
                                        time: 60,
                                        onTap: {}
                                    )
                                }
                            }.padding(.horizontal, 16)
                        }.tag(0)
                        ScrollView {
                            Text("Coming Soon...").font(.title)
                                .padding(16)
                        }.tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    Spacer()
                }
                .onChange(of: authViewModel.signOutState) { oldValue, newValue in
                    if newValue == .success {
//                        appwriteSessionID = ""
                        print("session id after sign out:: \(self.appwriteSessionID)")
                        navigator.replace(paths: ["signIn"], items: [:], isAnimated: true)
                    }
                }
                
                Button {
                    navigator.next(paths: ["addEditRecipe"], items: [:], isAnimated: true)
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color(UIColor(hex: "#1FCC79")))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }
                .padding()
                
                if authViewModel.signOutState == .error {
                    ToastView(
                        message: $authViewModel.apiResponseValue.wrappedValue
//                        type: $authViewModel.apiToastType.wrappedValue
                    )
                        .zIndex(1)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    authViewModel.signOutState = .initial
                                }
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                authViewModel.signOutState = .initial
                            }
                        }
                }
                
                if authViewModel.signOutState == .loading {
                    LoadingView()
                }
            }
            .navigationBarItems(
                trailing: Button(
                    action: {
                        self.showAlert = true
                    },
                    label: {
                        Image(systemName: "arrow.right.square")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                )
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Confirmation"),
                    message: Text("Are you sure you want to sign out?"),
                    primaryButton: .default(Text("Yes")) {
                        Task {
                            print("session id while logging out:: \(self.appwriteSessionID)")
                            await authViewModel.signOut(appwriteSessionID)
                        }
                    },
                    secondaryButton: .cancel(Text("No")) {
                        self.showAlert = false
                    }
                )
            }
        }
    }
    
    func customStringToDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: dateString)
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

//#Preview {
//    IRAProfileView()
//}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [String] = ["Recipes", "Liked"]
    
    var body: some View {
        HStack {
            ForEach(
                Array(
                    zip(self.tabBarOptions.indices,
                        self.tabBarOptions)
                ),
                id: \.0,
                content: {
                    index, name in
                    TabBarItem(
                        currentTab: self.$currentTab,
                        namespace: namespace.self,
                        tabBarItemName: name,
                        tab: index
                    )
                    
                }
            )
        }
        .frame(height: 45)
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Text(tabBarItemName)
                    .font(.system(size: 15))
                    .foregroundColor(Color(UIColor(hex: currentTab == tab ? "#3E5481" : "#9FA5C0")))
                    .fontWeight(.semibold)
                if currentTab == tab {
                    Color(UIColor(hex: "#1FCC79"))
                        .frame(height: 4)
                        .matchedGeometryEffect(
                            id: "underline",
                            in: namespace,
                            properties: .frame
                        )
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
        .buttonStyle(.plain)
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                Text("Signing Out...")
                    .foregroundColor(.white)
                    .padding(.top, 24)
            }
            .padding()
            .background(Color.gray.opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
}
