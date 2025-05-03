//
//  UserSheetView.swift
//  URLSession-Swagger-Practice
//
//  Created by 이유현 on 3/13/25.
//

import Foundation
import SwiftUI

struct UserSheetView : View {
    
    @Environment(\.dismiss) private var dismiss
    
    var user: UserModel? = nil
    
    var isNewUser: Bool {
        self.user == nil ? true : false
    }
    
    @Binding var showSheet: Bool
    @State var name: String = ""
    @State var age: String = ""
    @State var part: String = ""
    
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack{
            
            Text(isNewUser ? "새로운 멤버 추가하기" : "기존 멤버 수정하기")
                .font(.largeTitle).bold()
                .padding()
            
            HStack{
                Text("이름:")
                    .padding(.leading, 15)
                
                TextField("이름을 입력하세요", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            
            HStack{
                Text("나이:")
                    .padding(.leading, 15)
                
                TextField("나이를 입력하세요", text: $age)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
            }
            
            HStack{
                Text("파트:")
                    .padding(.leading, 15)
                
                TextField("파트를 입력하세요", text: $part)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            
            
            // 에러 메시지
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            
            Button(action:{
                //post
                if name.isEmpty || age.isEmpty || part.isEmpty {
                    errorMessage = "모든 항목을 입력해주세요."
                }else {
                    errorMessage = ""  // 에러 메시지 초기화
                    
                    Task {
                        if isNewUser {
                            //추가
                            let newUser = UserModel(name: name, age: Int(age) ?? 0, part: part)
                            await postUser(data: newUser)
                            showSheet = false
                            
                        } else {
                            // 수정
                            let newUser = UserModel(name: name, age: Int(age) ?? 0, part: part)
                            if let id = user?.id {
                                await updateUser(id: id, data: newUser)
                            }
                            
                            dismiss()
                        }
                    } // Task
                    
                }
                
            }){
                Text(isNewUser ? "추가" : "수정")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Spacer()
            
        } // VStack
        .onAppear {
            if let user = user {
                name = user.name
                age = String(user.age)
                part = user.part
            }
        }
    }
    
    //MARK: - post
    private func postUser(data: UserModel) async {
  
    }
    
    //MARK: - PATCH
    private func updateUser(id: Int, data: UserModel) async {
 
    }
}
