import React from 'react';

const Categories = () => {
  // SVG Icons for each category
  const PsychiatristIcon = () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 5a3 3 0 1 0-5.997.125 4 4 0 0 0-2.526 5.77 4 4 0 0 0 .556 6.588A4.5 4.5 0 0 0 12 22a4.5 4.5 0 0 0 7.972-2.657 4 4 0 0 0 .556-6.588 4 4 0 0 0-2.525-5.77A3 3 0 1 0 12 5"/>
      <path d="M9 13v-1h6v1"/>
      <path d="M12 12v3"/>
      <path d="M15 12a3 3 0 1 0-6 0"/>
    </svg>
  );

  const HepatologistIcon = () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 8c2.5 0 4 1.5 4 4v1c0 .5-.5 1-1 1H9c-.5 0-1-.5-1-1v-1c0-2.5 1.5-4 4-4z"/>
      <path d="M7 15v.5A2.5 2.5 0 0 0 9.5 18H14a2.5 2.5 0 0 0 2.5-2.5V15"/>
      <path d="M7 15H5a2 2 0 0 1-2-2v-2a2 2 0 0 1 2-2h2"/>
      <path d="M17 15h2a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2h-2"/>
    </svg>
  );

  const CardiologistIcon = () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.29 1.51 4.04 3 5.5l7 7Z"/>
      <path d="M12 8v4l3 3"/>
    </svg>
  );

  const DentalIcon = () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 8v13"/>
      <path d="M16 12a4 4 0 0 1-8 0"/>
      <path d="M5 16a13 13 0 0 0 14 0"/>
      <path d="M5 20a17 17 0 0 0 14 0"/>
      <path d="M9 4h6"/>
      <path d="M8 7h8"/>
    </svg>
  );

  const NephrologistIcon = () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 8c2.5 0 4 1.5 4 4v1c0 .5-.5 1-1 1H9c-.5 0-1-.5-1-1v-1c0-2.5 1.5-4 4-4z"/>
      <path d="M7 15v.5A2.5 0 0 0 9.5 18H14a2.5 2.5 0 0 0 2.5-2.5V15"/>
      <path d="M7 15H5a2 2 0 0 1-2-2v-2a2 2 0 0 1 2-2h2"/>
      <path d="M17 15h2a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2h-2"/>
    </svg>
  );

  const PulmonologistIcon = () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 8c2.5 0 4 1.5 4 4v1c0 .5-.5 1-1 1H9c-.5 0-1-.5-1-1v-1c0-2.5 1.5-4 4-4z"/>
      <path d="M7 15v.5A2.5 0 0 0 9.5 18H14a2.5 2.5 0 0 0 2.5-2.5V15"/>
      <path d="M7 15H5a2 2 0 0 1-2-2v-2a2 2 0 0 1 2-2h2"/>
      <path d="M17 15h2a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2h-2"/>
    </svg>
  );

  const DermatologistIcon = () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 8c2.5 0 4 1.5 4 4v1c0 .5-.5 1-1 1H9c-.5 0-1-.5-1-1v-1c0-2.5 1.5-4 4-4z"/>
      <path d="M7 15v.5A2.5 2.5 0 0 0 9.5 18H14a2.5 2.5 0 0 0 2.5-2.5V15"/>
      <path d="M7 15H5a2 2 0 0 1-2-2v-2a2 2 0 0 1 2-2h2"/>
      <path d="M17 15h2a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2h-2"/>
    </svg>
  );

  const GastroenterologistIcon = () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 8c2.5 0 4 1.5 4 4v1c0 .5-.5 1-1 1H9c-.5 0-1-.5-1-1v-1c0-2.5 1.5-4 4-4z"/>
      <path d="M7 15v.5A2.5 2.5 0 0 0 9.5 18H14a2.5 2.5 0 0 0 2.5-2.5V15"/>
      <path d="M7 15H5a2 2 0 0 1-2-2v-2a2 2 0 0 1 2-2h2"/>
      <path d="M17 15h2a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2h-2"/>
    </svg>
  );

  const categories = [
    { name: 'Psychiatrist', icon: <PsychiatristIcon /> },
    { name: 'Hepatologist', icon: <HepatologistIcon /> },
    { name: 'Cardiologist', icon: <CardiologistIcon /> },
    { name: 'Dental', icon: <DentalIcon /> },
    { name: 'Nephrologist', icon: <NephrologistIcon /> },
    { name: 'Pulmonologist', icon: <PulmonologistIcon /> },
    { name: 'Dermatologist', icon: <DermatologistIcon /> },
    { name: 'Gastroenterologist', icon: <GastroenterologistIcon /> }
  ];

  return (
    <div className="max-w-6xl mx-auto px-4 py-8">
      {/* Header */}
      <h2 className="text-2xl font-semibold text-blue-900 mb-6 text-left">
        Categories
      </h2>
      
      {/* Grid Layout */}
      <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
        {categories.map((category, index) => (
          <button
            key={index}
            className="flex flex-col items-center justify-center p-4 bg-white border border-gray-100 rounded-3xl hover:shadow-md transition-shadow duration-200 h-32"
          >
            <div className="mb-2 text-blue-600">
              {category.icon}
            </div>
            <span className="text-xs text-gray-500 text-center truncate max-w-full">
              {category.name.length > 12 ? `${category.name.substring(0, 10)}...` : category.name}
            </span>
          </button>
        ))}
      </div>
    </div>
  );
};

export default Categories;