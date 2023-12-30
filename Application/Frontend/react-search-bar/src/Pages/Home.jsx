// ============================================================
// SearchEngineTwo
// ============================================================

import React from "react";
import { Grid, Header, Icon, Container } from "semantic-ui-react";

import SearchEngineTwo from "../Components/SearchEngineTwo/SearchEngineTwo";

export default function Home() {
  return (
    <>
      <Container style={{ marginTop: "5em" }}>
        <Grid columns={3}>
          <Grid.Row>
            <Grid.Column width={3}></Grid.Column>
            <Grid.Column textAlign="center" verticalAlign="middle" width={10}>
              <Header as="h1" color="teal" textAlign="center">
                <Icon name="search" /> Digital Library
              </Header>
            </Grid.Column>
            <Grid.Column width={3}></Grid.Column>
          </Grid.Row>

          <Grid.Row>
            <Grid.Column width={3}></Grid.Column>
            <Grid.Column textAlign="center" verticalAlign="middle" width={10}>
              <SearchEngineTwo />
            </Grid.Column>
            <Grid.Column width={3}></Grid.Column>
          </Grid.Row>
        </Grid>
      </Container>
    </>
  );
}

// ============================================================
// SearchEngineOne
// ============================================================

// // react imports
// import React from "react";
// import { useState } from "react";
// // import { useNavigate, Link } from "react-router-dom";

// // component imports
// import { SearchBar } from "../Components/SearchEngine/SearchBar";
// import { SearchResultsList } from "../Components/SearchEngine/SearchResultsList";

// export default function Home() {
//   const [results, setResults] = useState([]);

//   // navigate back hook
//   // const navigate = useNavigate();

//   return (
//     <>
//       <div className="App">
//         <div className="search-bar-container">
//           {/* navigate back button */}
//           {/* <button className="btn" onClick={() => navigate(-1)}>
//             Go Back
//           </button> */}

//           {/* search bar */}
//           <SearchBar setResults={setResults} />

//           {/* suggestion list display*/}
//           {results && results.length > 0 && (
//             <SearchResultsList results={results} />
//           )}
//         </div>
//       </div>
//     </>
//   );
// }
