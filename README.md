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