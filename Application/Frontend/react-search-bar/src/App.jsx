import { Routes, Route } from "react-router-dom";
import "./App.css";

import NavBar from "./Components/Navbar/NavBar";

import Home from "./Pages/Home";
import SearchedBooks from "./Pages/SearchedBooks";

function App() {
  return (
    <>
      <NavBar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/searched-books" element={<SearchedBooks />} />
      </Routes>
    </>
  );
}

export default App;
