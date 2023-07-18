import React, { useEffect, useState } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Receptionist from "./Receptionist";
import Doctor from "./Doctor";
import Nurse from "./Nurse";
import Pharmacist from "./Pharmacist";

import Admin from "./Admin";
import UserRegistration from "./UserRegistration";
import Login from "./Login";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="nurse" element={<Nurse />} />
        <Route path="receptionist" element={<Receptionist />} />
        <Route path="doctor" element={<Doctor />} />
        <Route path="pharmacist" element={<Pharmacist />} />
        <Route path="admin" element={<Admin />} />\
        <Route path="user-registration" element={<UserRegistration />} />
        <Route path="login" element={<Login />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
