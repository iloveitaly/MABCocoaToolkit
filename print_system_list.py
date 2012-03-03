#!/usr/bin/python

from AppKit import NSMutableDictionary, NSURL
    
models = NSMutableDictionary.dictionaryWithContentsOfURL_(NSURL.URLWithString_("https://raw.github.com/andymatuschak/Sparkle/4d00e8c569933dc7576a7b501f3caea0f4d30737/SUModelTranslation.plist"))

for model in models:
    print "@\"%s\", @\"%s\"," % (models[model], model)