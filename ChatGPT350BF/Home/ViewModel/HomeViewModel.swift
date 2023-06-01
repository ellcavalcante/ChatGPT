//
//  HomeViewModel.swift
//  ChatGPT350BF
//
//  Created by Ellington Cavalcante on 31/05/23.
//

import UIKit

class HomeViewModel: NSObject {
    
    private var messageList: [Message] = [Message(message: "Oi, tudo bem?", typeMessage: .user),
                                          Message(message: "Olá, tudo otimo!", typeMessage: .chatGPT),
    ]
    
    var numberOfRowsInSection: Int {
        return messageList.count
    }
    
    func loadCurrentMessage(indexPath: IndexPath) -> Message {
        return messageList[indexPath.row]
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return messageList[indexPath.row].message.heightWithConstrainedWidth(width: 220, font: UIFont(name: "HelveticaNeue-Medium", size: 16) ?? UIFont()) + 60
    }
    
    public func addMessage(message: String, type: TypeMessage = .user) {
        messageList.insert(Message(message: message.trimmingCharacters(in: .whitespacesAndNewlines), typeMessage: type), at: .zero)
    }
}
