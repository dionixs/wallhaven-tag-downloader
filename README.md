# wallhaven-tag-downloader
:mag: Wallpaper Downloader from wallhaven.cc (by specific tag)

# Run
```
bundle install
bundle exec ruby main.rb
```

Before running the program, need to edit a file settings.json
```
 "api": "<your_key>",
 "categories": "<number>" \\ 100/101/111 (general/anime/people)
 "purity": "<number>" \\ 100/110/111 (sfw/sketchy/nsfw)
 "sorting": "<sorting>" \\ date_added/relevance/random/views/favorites/toplist
 "order": "<order>" \\ desc/asc
 "resolution": "<your_resolution>"
 "tag": "<tag_to_search>"
```

# Requirements
- ruby-2.7.0