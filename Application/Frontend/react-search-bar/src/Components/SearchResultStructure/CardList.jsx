import React from 'react';
import { Card, Image } from 'semantic-ui-react';

const CardList = ({ dataList }) => {
  return (
    <Card.Group>
      {dataList.map((item, index) => (
        <Card key={index}>
          <Image src={item.image} wrapped ui={false} />
          <Card.Content>
            <Card.Header>{item.title}</Card.Header>
            <Card.Meta>{item.meta}</Card.Meta>
            <Card.Description>{item.description}</Card.Description>
          </Card.Content>
          {/* Add more Card.Content or Card.Meta sections as needed */}
        </Card>
      ))}
    </Card.Group>
  );
};

export default CardList;
