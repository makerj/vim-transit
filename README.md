# vim-transit

This plugin translates a given text from source language to target language via Google Translate API.

## Variables

You can configure this plugin using following variables

```
let g:transit_src = 'en'
let g:transit_dst = 'ko'
```

Also, you must have a Google Cloud API Key environment variable

```
# In your shell or shell rc
export GOOGLE_CLOUD_API_KEY=<your key>
```
