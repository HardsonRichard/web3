import React, { useEffect, useState } from "react";
import { init, login } from "./Web3client";

const Login = () => {
  const [credentials, setCredentials] = useState({
    email: "",
    password: "",
  });
  useEffect(() => {
    init();
  }, []);
  const handleChange = (e) => {
    setCredentials({
      ...credentials,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const { email, password } = credentials;

    login(email, password)
      .then((result) => console.log("Logged in", result))
      .catch((error) => {
        console.error("Login failed", error);
        // Handle the error appropriately
      });
  };
  return (
    <div className="max-w-md mx-auto bg-white mt-4 p-4 shadow-md rounded-md mt-20">
      <div className="flex justify-center">
        <h2 className="text-base text-black font-medium mb-4">
          USER REGISTRATION
        </h2>
      </div>
      <form onSubmit={handleSubmit}>
        <div>
          <div className="mb-4">
            <label htmlFor="email" className="block text-gray-700">
              Email
            </label>
            <input
              type="email"
              id="email"
              name="email"
              value={credentials.email}
              onChange={handleChange}
              className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              required
            />
          </div>
          <div className="mb-4">
            <label htmlFor="password" className="block text-gray-700">
              Password
            </label>
            <input
              type="password"
              id="password"
              name="password"
              value={credentials.password}
              onChange={handleChange}
              className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              required
            />
          </div>
        </div>
        <div className="flex justify-center mt-6">
          <button
            type="submit"
            className="bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded-md"
          >
            Submit
          </button>
        </div>
      </form>
    </div>
  );
};

export default Login;
