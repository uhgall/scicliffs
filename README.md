# scicliffs
The Quick Dive into Deep Science

## Pitch

Join the AI Revolution! 🚀 We're launching a crowdsourced, ever-evolving distributed network of online science magazines. By using our browser extension, you're not just a reader - you contribute! Leveraging AI and large language models, we auto-archive, extract, and transform science papers into accessible articles. As our user base grows, so does our content. Dive in, and let's make* science universally understandable together!

## Architecture

* a web service that simply consumes a PDF file?
* for purposes of hackathon, we can hardcode destination of where the generated article is posted

## TODO - Essential

* Converting PDF to text. Ulrich has a minimalist solution, but it's not great
* Generate the actual content. See gen/generator.rb as a strawman. Lots of ways to improve it.

## TODO - Stretch Goals

* Generate images and add them to the article. Ulrich already added code to generate the prompts to gen/generate.rb

* More elegant sources of articles
- paste URL?
- mod a browser plugin that is design to upload papers elsewhere? 
- Just use the arxiv feed? 

* Automatically submit them to substack? But, no API? Rob? 

* Allow users to describe their style, audience, etc?


## Running the ruby code

** This project uses Glim, a pre alpha library for using LLMs. TODO: Make a publicly accessible version. **

```
git clone git@github.com:uhgall/scicliffs.git
cp sample.env .env # modify this to add your API keys
bundle
ruby gen/generate.rb
```

## What does Glim buy us? 

* supports Claude and OpenAI (and also Llama2 via anyscale)
* caches results so if there is a bug in your code, it will run quickly the nect time you run it, etc. 
* various convenience features - token counting, cost calculation, file extraction, templating language for prompts (erb), logging