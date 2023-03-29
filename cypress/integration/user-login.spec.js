describe('User Login', () => {

  beforeEach(() => {
    cy.visit('/');
  });

  it('There is 2 products on the page', () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('User can login successfully', () => {
    cy.get("a[href='/login']").click();
    cy.get("#email").type("fred@fred.com");
    cy.get("#password").type("12345678");
    cy.get("form").submit();
    cy.get("#navbarSupportedContent").should('include.text', 'Fred');
  });

  it('User can sign up successfully, logout, then login', () => {
    cy.get("a[href='/signup']").click();
    cy.get("#user_first_name").type("Bobbert");
    cy.get("#user_last_name").type("Boberson");
    cy.get("#user_email").type("bob@bob.com");
    cy.get("#user_password").type("hardpassword");
    cy.get("#user_password_confirmation").type("hardpassword");
    cy.get("form").submit();
    cy.get("#navbarSupportedContent").should('include.text', 'Bobbert');
  });

})
