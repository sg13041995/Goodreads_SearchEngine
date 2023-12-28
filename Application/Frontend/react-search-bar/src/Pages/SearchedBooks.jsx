import React, { useState, useEffect } from 'react';
import _ from 'lodash';
import faker from 'faker';
import { Search, Grid, Header, Segment } from 'semantic-ui-react';

const source = _.times(5, () => ({
  title: faker.company.companyName(),
  description: faker.company.catchPhrase(),
  image: faker.internet.avatar(),
  price: faker.finance.amount(0, 100, 2, '$'),
}));

const initialState = { isLoading: false, results: [], value: '' };

const SearchedBooks = () => {
  const [state, setState] = useState(initialState);

  const handleResultSelect = (e, { result }) => setState({ value: result.title });

  const handleSearchChange = (e, { value }) => {
    setState({ isLoading: true, value });

    setTimeout(() => {
      if (value.length < 1) return setState(initialState);

      const re = new RegExp(_.escapeRegExp(value), 'i');
      const isMatch = (result) => re.test(result.title);

      setState({
        isLoading: false,
        results: _.filter(source, isMatch),
      });
    }, 300);
  };

  return (
    <Grid>
      <Grid.Column width={6}>
        <Search
          fluid
          loading={state.isLoading}
          onResultSelect={handleResultSelect}
          onSearchChange={_.debounce(handleSearchChange, 500, {
            leading: true,
          })}
          results={state.results}
          value={state.value}
        />
      </Grid.Column>
      <Grid.Column width={10}>
        <Segment>
          <Header>State</Header>
          <pre style={{ overflowX: 'auto' }}>
            {JSON.stringify(state, null, 2)}
          </pre>
          <Header>Options</Header>
          <pre style={{ overflowX: 'auto' }}>
            {JSON.stringify(source, null, 2)}
          </pre>
        </Segment>
      </Grid.Column>
    </Grid>
  );
};

export default SearchedBooks;
