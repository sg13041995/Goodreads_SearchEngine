import React from "react";
import { Grid, Header, Icon, Container } from "semantic-ui-react";

import SearchBar from "../Components/SearchBar/SearchBar";

export default function Home() {
  return (
    <>
      <Container style={{ marginTop: "5em" }}>
        <Grid columns={3}>
          <Grid.Row>
            <Grid.Column width={3}></Grid.Column>
            <Grid.Column textAlign="center" verticalAlign="middle" width={10}>
              <Header as="h1" color="teal" textAlign="center">
                <Icon name="search" /> Digital Library Search
              </Header>
            </Grid.Column>
            <Grid.Column width={3}></Grid.Column>
          </Grid.Row>

          <Grid.Row>
            <Grid.Column width={3}></Grid.Column>
            <Grid.Column textAlign="center" verticalAlign="middle" width={10}>
              <SearchBar />
            </Grid.Column>
            <Grid.Column width={3}></Grid.Column>
          </Grid.Row>
        </Grid>
      </Container>
    </>
  );
}
