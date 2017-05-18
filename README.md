# vim-transit

![demo](demo.gif)

This plugin translates a given text from source language to target language via Google Translate API.

## Prerequisite

* vim with python support
* python [requests](http://docs.python-requests.org/en/master/)

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

## Usage

### Command Mode

Print translated text to status line

```
:TransIt I love you
```

Put translated text to current buffer
```
:TransItPut I love you
```

### Visual Mode

Print translated text to status line

```
:'<,'>TransItBlock
```

Put translated text to current buffer
```
:'<,'>TransItBlockPut
```

