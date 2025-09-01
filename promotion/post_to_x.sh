#!/bin/bash

# Script to post music content to X (Twitter) via Zapier webhook
# Author: Ran Chen
# Description: Posts the first track from "Music for Dogs" album to X platform

# X (Twitter) character limit is 280 characters
# We need to keep the post concise while including the essential information

# Music details from the first track
TRACK_TITLE="Music for French Bulldog"
TRACK_URL="https://www.youtube.com/watch?v=b02OQIi5LPo&list=OLAK5uy_nLCBYNrJuVX1UK-CPmhk9jh6sAoA3ztxk"
ALBUM_TITLE="Music for Dogs"
RELEASE_DATE="2025-08-19"

# Create the post content (keeping under 280 characters)
# Format: 🎵 [Track] from [Album] - [Short description] [URL] #hashtags
POST_CONTENT="🎵 ${TRACK_TITLE} from ${ALBUM_TITLE} 🐕

Cheerful indie pop with ukulele melody - perfect for sunny afternoon vibes! 🎶☀️

${TRACK_URL}

#MusicForDogs #IndiePopMusic #PetMusic"

# Check content length (X limit is 280 characters)
CONTENT_LENGTH=${#POST_CONTENT}
echo "Content length: $CONTENT_LENGTH characters"

if [ $CONTENT_LENGTH -gt 280 ]; then
    echo "⚠️  Warning: Content exceeds 280 character limit for X (Twitter)"
    echo "Current length: $CONTENT_LENGTH characters"
    echo "Please shorten the content before posting."
    exit 1
fi

echo "Content preview:"
echo "=================="
echo "$POST_CONTENT"
echo "=================="
echo ""

# Ask for confirmation before posting
read -p "Do you want to post this to X? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Post cancelled."
    exit 0
fi

# Post to X via Zapier webhook
echo "Posting to X platform..."

curl -X POST "https://hooks.zapier.com/hooks/catch/1861936/uhwb5f7/" \
  -H "Content-Type: application/json" \
  -d '{
    "user": "Ran Chen",
    "content": "'"$POST_CONTENT"'",
    "timestamp": "'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'"
  }'

echo ""
echo "✅ Post sent to X platform!"
echo "📊 Content length: $CONTENT_LENGTH/280 characters"