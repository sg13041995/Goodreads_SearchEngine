import { Routes, Route } from "react-router-dom";

import NavBar from "./Components/Navbar/NavBar";

import Home from "./Pages/Home";
import TopBooks from "./Pages/TopBooks";
import NoMatch from "./Components/NoMatch/NoMatch"

import "./App.css";

function App() {
  return (
    <>
      <NavBar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/top-books" element={<TopBooks />} />
        <Route path="*" element={<NoMatch />} />
      </Routes>
    </>
  );
}

export default App;
