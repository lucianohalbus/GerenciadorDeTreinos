//
//  CelulaDeTreinoPrincipal.swift
//  GerenciadorDeTreinos
//
//  Created by Luciano Puzer on 27/11/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine

struct TrainingCellView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @State var selectedTraining:MainModel?
    @State private var showEditTraining = false
    @State private var showDeleteSheet = false
    @State private var showEditSheet = false
    @State var changePage:Bool = false
    
    var body: some View {
        HStack {
            ForEach (mainViewModel.mainModel) { task in
                VStack {
                    ZStack(alignment: .leading) {
                        Image(task.suggestedTraining ? "imageTreinoJoelho": "imageTreinoBackground")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                            .frame(width: 320, height: 200)
                            .onTapGesture {
                                self.mainViewModel.initialMainTraining.userId = Auth.auth().currentUser!.uid
                                self.mainViewModel.initialMainTraining.id = task.id
                                changePage.toggle()
                            }
                        NavigationLink ("", destination: TrainingListView(),
                                        isActive: $changePage)
                        Text(task.name)
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .offset(x: 0, y: 20)
                            .padding()
                        VStack {
                            Spacer()
                            Image(systemName: "multiply.circle")
                                .foregroundColor(Color.gray)
                                .padding(20)
                                .offset(x: 260, y: -20)
                                .onTapGesture {
                                    self.selectedTraining = task
                                    self.showDeleteSheet.toggle()
                                }
                                .actionSheet(isPresented: $showDeleteSheet) {
                                    ActionSheet(title: Text("Excluir Treino Definitivamente"), message: nil, buttons: [
                                        .destructive(Text("Excluir"),
                                                     action: {
                                                         if let selectedTraining = self.selectedTraining {
                                                             if selectedTraining.suggestedTraining == false {
                                                                 self.delete(treinoModels: selectedTraining)
                                                             }
                                                             else{
                                                                 print("The training can not be excluded")
                                                             }
                                                         }
                                                     }),
                                        .cancel()
                                    ])
                                }
                            Spacer()

                            Image(systemName: "gearshape")
                                .foregroundColor(Color.gray)
                                .padding(30)
                                .offset(x: -20, y: -120)
                                .onTapGesture {
                                    self.mainViewModel.initialMainTraining.userId = Auth.auth().currentUser!.uid
                                    self.mainViewModel.initialMainTraining.id = task.id
                                    self.mainViewModel.editableDoc = true
                                    self.mainViewModel.initialMainTraining.name = task.name
                                    self.mainViewModel.initialMainTraining.description = task.description
                                    self.mainViewModel.initialMainTraining.userId = task.userId
                                    self.showEditSheet.toggle()
                                }
                                .actionSheet(isPresented: $showEditSheet, content: actionSheet)
                                .sheet(isPresented: $showEditTraining, onDismiss: {
                                    
                                }) {
                                    AddMainTraining()
                                }
                        }
                    }.frame(width: 300, height: 200)
                }.frame(width: 350, height: 200)
            }
        }.background(Color("mainBackground"))
    }
    
    func delete(treinoModels: MainModel) {
        mainViewModel.removeTraining(treinoModels)
    }
    
    private func actionSheet() -> ActionSheet {
        let button1 = ActionSheet.Button.default(Text("Edit")) {
            self.showEditSheet = false
            self.showEditTraining = true
        }
        
        let actionSheet = ActionSheet(title: Text("Escolha uma opção"),
                                      message: nil,
                                      buttons: [button1, .cancel()])
        return actionSheet
    }
}

struct MainTrainingCell_Previews: PreviewProvider {
    static var previews: some View {
        TrainingCellView()
            .previewLayout(.sizeThatFits)
            .environmentObject(MainViewModel())
    }
}


