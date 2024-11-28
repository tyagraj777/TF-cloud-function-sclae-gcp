# TF-cloud-function-sclae-gcp
Terraform automation to deploy Google Cloud Functions that scale based on load with sample run using Apache Benchmark

1. need to install ab (apache benchmark) for load testing of function
2. remove / update unauthorised invoking of function if neeeded
3. function code for sample node.js function (.zip)


Description:

Purpose: A simple HTTP function that responds with "Hello, [name]!".

Parameters: Accepts name from the query string, request body, or defaults to "World".

Response: Returns a 200 status with a message.
