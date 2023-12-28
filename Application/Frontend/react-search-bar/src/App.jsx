import { Routes, Route } from "react-router-dom";

import NavBar from "./Components/Navbar/NavBar";

import Home from "./Pages/Home";
import SearchResults from "./Pages/SearchResults";
import TopBooks from "./Pages/TopBooks";
import NoMatch from "./Components/NoMatch/NoMatch"

import "./App.css";

function App() {
  return (
    <>
      <NavBar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/search-results" element={<SearchResults />} />
        <Route path="/top-books" element={<TopBooks />} />
        <Route path="*" element={<NoMatch />} />
      </Routes>
    </>
  );
}

export default App;
