// react basic imports
import React from "react";
import ReactDOM from "react-dom/client";

// react router imports
import { BrowserRouter } from "react-router-dom";

// bootstrap css import
import 'bootstrap/dist/css/bootstrap.min.css';

// react components import
import App from "./App.jsx";

// react css imports
import "./index.css";

// react main body
ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </React.StrictMode>
);
