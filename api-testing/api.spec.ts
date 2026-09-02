import { test, expect } from '@playwright/test';

test.describe('REST API Testing', () => {

  test('GET - retrieve user data successfully', async ({ request }) => {
    const response = await request.get(
      'https://jsonplaceholder.typicode.com/users/1'
    );

    expect(response.status()).toBe(200);

    const body = await response.json();

    expect(body).toHaveProperty('id', 1);
    expect(body).toHaveProperty('name');
    expect(body).toHaveProperty('email');
  });

  test('POST - create a new resource', async ({ request }) => {
    const response = await request.post(
      'https://jsonplaceholder.typicode.com/posts',
      {
        data: {
          title: 'QA Automation Test',
          body: 'API testing with Playwright',
          userId: 1
        }
      }
    );

    expect(response.status()).toBe(201);

    const body = await response.json();

    expect(body.title).toBe('QA Automation Test');
    expect(body.userId).toBe(1);
  });

  test('GET - validate resource not found', async ({ request }) => {
    const response = await request.get(
      'https://jsonplaceholder.typicode.com/posts/999999'
    );

    expect(response.status()).toBe(404);
  });

});
