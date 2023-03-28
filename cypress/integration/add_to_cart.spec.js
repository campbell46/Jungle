describe('Add to Cart', () => {

  beforeEach(() => {
    cy.visit('/');
  });

  it('There is 2 products on the page', () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('The cart count goes up by 1 when adding product to cart', () => {
    cy.get("form.button_to").first().submit();
    cy.get(".nav-item.end-0").should('include.text', "My Cart (1)");
  });

});

