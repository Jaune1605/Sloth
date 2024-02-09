import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

const Users = () => {
  const [users, setUsers] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    fetch('http://192.168.40.6:3000/users')
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        const filteredUsers = data.filter(user => {
          // Liste des noms à afficher
          const allowedNames = ['john.pade', 'paul.fournet', 'henri.vanlemmens', 'theo.lomege'];
          return allowedNames.includes(user.sAMAccountName.toLowerCase());
        });
        setUsers(filteredUsers);
      })
      .catch(error => {
        console.error('There has been a problem with your fetch operation:', error);
      });
  }, []);

  const handleUserClick = (userName) => {
    navigate(`/users/${userName}`);
  };

  return (
    <div className="bg-white py-24 sm:py-32">
      <div className="mx-auto max-w-7xl gap-x-8 gap-y-20 px-6 lg:px-8">
        <h2 className="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">Meet our leadership</h2>
        <div className="mt-6 text-lg leading-8 text-gray-600">
          Here are your team members.
        </div>
        <div className="mt-8 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">
          {users.map((user, index) => (
            <div key={index} className="flex flex-col items-center bg-gray-100 p-4 rounded-lg cursor-pointer" onClick={() => handleUserClick(user.sAMAccountName)}>
              <div className="text-lg font-medium text-gray-900">{user.sAMAccountName}</div>
              <div className="text-sm text-gray-600">{user.userPrincipalName}</div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Users;

  /*
  const people = [
      {
        name: 'FOURNET Paul',
        role: 'dark shit / KK',
        imageUrl:
          'data:image/jpeg;base64,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',
      },
      {
          name: 'LOMEGE Théo',
          role: 'dirty boy / KK2',
          imageUrl:
              'https://static.wikia.nocookie.net/harrypotter/images/f/f8/PromoHP7_Hermione_Granger.jpg/revision/latest?cb=20230112064229&path-prefix=fr',
      },
      // More people...
    ]*/