import React from "react";
import { useState } from "react";
// import { useNavigate, Link } from "react-router-dom";

import { SearchBar } from "../Components/SearchEngine/SearchBar";
import { SearchResultsList } from "../Components/SearchEngine/SearchResultsList";

export default function Home() {
  const [results, setResults] = useState([]);

  // navigate back hook
  // const navigate = useNavigate();

  return (
    <>
      <div className="App">
        <div className="search-bar-container">
          {/* navigate back button */}
          {/* <button className="btn" onClick={() => navigate(-1)}>
            Go Back
          </button> */}

          {/* search bar */}
          <SearchBar setResults={setResults} />

          {/* suggestion list display*/}
          {results && results.length > 0 && (
            <SearchResultsList results={results} />
          )}
        </div>
      </div>
    </>
  );
}
