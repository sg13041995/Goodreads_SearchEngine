import { useState, useEffect } from "react";
import { FaSearch } from "react-icons/fa";

import "./SearchBar.css";

export const SearchBar = ({ setResults }) => {
  const [input, setInput] = useState("");

  useEffect(() => {
    // Set up a timer for debouncing
    const timer = setTimeout(() => {
      fetchData(input);
    }, 500); // Adjust the delay (in milliseconds) based on your requirements

    // Cleanup function to clear the timer when component unmounts or when input changes
    return () => clearTimeout(timer);
  }, [input]);

  const fetchData = async (value) => {
    try {
      const response = await fetch(`http://127.0.0.1:5000/api/titles-all?query=${value}`);
      const json = await response.json();
      const results = json;
      setResults(results);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  // Handle changes in the input field
  const handleChange = (value) => {
    setInput(value);
  };

  return (
    <div className="input-wrapper">
      <FaSearch id="search-icon" />
      <input
        placeholder="Type to search..."
        value={input}
        onChange={(e) => handleChange(e.target.value)}
      />
    </div>
  );
};
