describe('Product Page', () => {

  beforeEach(() => {
    cy.visit('/');
  })

  it('There is 2 products on the page', () => {
    cy.get(".products article").should("have.length", 2);
  })

  it('When clicking on a product, it loads product detail page', () => {
    cy.get('[alt="Scented Blade"]').click();
    cy.get('.page-header h1').should('include.text', 'Scented Blade');
    // The product description should be displayed
    cy.get('.product-detail p').should('include.text', 'The Scented Blade is an extremely rare, tall plant and can be found mostly in savannas. It blooms once a year, for 2 weeks.')
  })

})

