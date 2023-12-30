import React from "react";
import CardList from "./CardList";

export default function CardDataSource() {
  const dataList = [
    {
      image: "image1.jpg",
      title: "Card 1",
      meta: "Meta 1",
      description: "Description 1",
    },
    {
      image: "image2.jpg",
      title: "Card 2",
      meta: "Meta 2",
      description: "Description 2",
    },
    {
      image: "image1.jpg",
      title: "Card 1",
      meta: "Meta 1",
      description: "Description 1",
    },
    {
      image: "image2.jpg",
      title: "Card 2",
      meta: "Meta 2",
      description: "Description 2",
    },
    {
      image: "image1.jpg",
      title: "Card 1",
      meta: "Meta 1",
      description: "Description 1",
    },
    {
      image: "image2.jpg",
      title: "Card 2",
      meta: "Meta 2",
      description: "Description 2",
    },
    // Add more data objects as needed
  ];

  return <CardList dataList={dataList} />;
}
