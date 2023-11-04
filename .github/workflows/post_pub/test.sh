#!/bin/bash

issue_data=$(cat .github/workflows/post_pub/test.json)
node .github/workflows/post_pub/issue_to_post.js "$issue_data"
