import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Search, Grid } from "semantic-ui-react";

const initialState = { isLoading: false, results: [], value: "" };

const SearchEngineTwo = () => {
  const [state, setState] = useState(initialState);
  const navigate = useNavigate();

  const handleResultSelect = (e, { result }) => {
    setState({ value: result.title });
    navigate("/search-results");
  };

  const handleSearchChange = (e, { value }) => {
    setState((prev) => ({ ...prev, isLoading: true, value }));
  };

  useEffect(() => {
    let timeoutId;

    const search = async () => {
      try {
        const response = await fetch(
          `http://127.0.0.1:5000/api/books-search?query=${state.value}`
        );
        const data = await response.json();

        setState((prev) => ({
          ...prev,
          isLoading: false,
          results: data, // Assuming your API response has a 'results' property
        }));
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    // Cleanup function to clear the timeout
    const cleanup = () => {
      if (timeoutId) {
        clearTimeout(timeoutId);
      }
    };

    // Debounce the search by delaying it for 500ms
    timeoutId = setTimeout(() => {
      cleanup();
      search();
    }, 500);

    return cleanup;
  }, [state.value]);

  return (
    <div>
      <Search
        fluid
        loading={state.isLoading}
        onResultSelect={handleResultSelect}
        onSearchChange={(e, { value }) => handleSearchChange(e, { value })}
        results={state.results}
        value={state.value}
      />
    </ div>
  );
};

export default SearchEngineTwo;
