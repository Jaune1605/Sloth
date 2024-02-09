// src/components/Profile.jsx
import React from 'react';
import { useParams } from 'react-router-dom';

const Profile = () => {
  let { userName } = useParams();

  return (
   
    <div className="bg-white py-24 sm:py-32">
    <div className="mx-auto max-w-7xl gap-x-8 gap-y-20 px-6 lg:px-8">
      <h2 className="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">Profile Page</h2>
      <div className="mt-6 text-lg leading-8 text-gray-600">
        Worker de qualité.
      </div>
      <div className="mt-8  gap-10">
            
          <div className="flex flex-col items-center bg-gray-100 p-4 rounded-lg cursor-pointer">
            <div className="text-lg font-medium text-gray-900">{userName}</div>
            <div className="text-sm text-gray-600">Liste des qualités exceptionnelles de ce membre indispensable</div>
          </div>
      </div>
    </div>
  </div>
  );
};

export default Profile;
