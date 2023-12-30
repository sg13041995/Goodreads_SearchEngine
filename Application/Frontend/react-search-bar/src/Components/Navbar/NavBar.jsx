import React from "react";
import { NavLink } from "react-router-dom";

// bootstrap Navbar imports
import Container from "react-bootstrap/Container";
import Nav from "react-bootstrap/Nav";
import Navbar from "react-bootstrap/Navbar";

export default function NavBar() {
  return (
    <div>
      {/* bootstrap navbar */}
      <Navbar expand="lg" className="bg-body-tertiary">
        <Container>
          <Navbar.Brand>DigiLib</Navbar.Brand>
          <Navbar.Toggle aria-controls="basic-navbar-nav" />
          <Navbar.Collapse id="basic-navbar-nav">
            <Nav className="me-auto">
              <Nav.Link>
                <div>
                  <NavLink to="/">Home</NavLink>
                </div>
              </Nav.Link>
              <Nav.Link>
                <div>
                  <NavLink to="/top-books">Top Books</NavLink>
                </div>
              </Nav.Link>
            </Nav>
          </Navbar.Collapse>
        </Container>
      </Navbar>
    </ div>
  );
}
