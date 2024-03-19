// src/components/ChatBot.js
import React, { useState } from 'react';

export default function ChatBot() {
  const [messages, setMessages] = useState([]);

  const sendMessage = (msg) => {
    // Ici, vous ajouterez la logique pour envoyer le message à l'API Mistral et recevoir la réponse
    console.log(msg);
    // Simuler une réponse
    setMessages([...messages, { id: Date.now(), text: msg, from: 'user' }, { id: Date.now() + 1, text: 'Mistral : Euuu oui je crois bien', from: 'bot' }]);
  };

  return (
    <div className="flex justify-start items-center h-screen">
      <div className="p-4 max-w-md">
        <h1 className="text-xl font-bold text-center mb-4">Let's Chat</h1>
        <div className="mb-4">
          {messages.map((msg) => (
            <div key={msg.id} className={`text-sm p-2 ${msg.from === 'user' ? 'text-right' : 'text-left'}`}>
              {msg.text}
            </div>
          ))}
        </div>
        <div>
          <input type="text" onKeyDown={(e) => e.key === 'Enter' && sendMessage(e.target.value)} className="border p-2 w-full" placeholder="Écrivez votre message ici..." />
        </div>
      </div>
    </div>
  );
}
