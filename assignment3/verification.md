# Assignment 3 verification

I started the services with `docker compose up --build -d` and then ran this from the repo root:

```text
$ make test-e2e BASE_URL=http://localhost:8080
python3 assignment3/tests/e2e.py "http://localhost:8080"
PASS test_frontend
PASS test_status_and_request_id
PASS test_health_and_readiness
PASS test_version_metadata
PASS test_seeded_quote_is_present
PASS test_random_quote_and_counter
PASS test_create_and_read_quote
All contract tests passed for http://localhost:8080
```

I also ran the MongoDB seed script again. It still had 50 starter quotes afterward, so it did not add duplicates.

I clicked "Get quote" in the browser after simplifying the frontend. It showed a quote and the "Quotes Received" count. The contract test also checked that the count increases on the next request.
