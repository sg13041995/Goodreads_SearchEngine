// basic react import
import React from "react";
import { NavLink } from "react-router-dom";

// semantic ui imports
import {Icon} from "semantic-ui-react";

// bootstrap Navbar imports
import Container from "react-bootstrap/Container";
import Nav from "react-bootstrap/Nav";
import Navbar from "react-bootstrap/Navbar";

// NavBar css
import "./NavBar.css"

// component function
export default function NavBar() {
  return (
    <div>
      {/* bootstrap navbar */}
      <Navbar expand="lg" className="bg-body-tertiary" data-bs-theme="dark">
        <Container>
          <Navbar.Brand><Icon name="book" /> Digital Library</Navbar.Brand>
          <Navbar.Toggle aria-controls="basic-navbar-nav" />
          <Navbar.Collapse id="basic-navbar-nav">
            <Nav className="me-auto"></Nav>
            <Nav>
              <Nav.Link className="topnav">
                <NavLink to="/">Home</NavLink>
              </Nav.Link>
              <Nav.Link className="topnav">
                <NavLink to="/top-books">Top Books</NavLink>
              </Nav.Link>
            </Nav>
          </Navbar.Collapse>
        </Container>
      </Navbar>
    </div>
  );
}
