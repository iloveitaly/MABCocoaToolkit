#!/usr/bin/python

# takes the sparkle system name plist and prints it out as a string that can be used in an NSDictionary initializer

from AppKit import NSMutableDictionary, NSURL
    
models = NSMutableDictionary.dictionaryWithContentsOfURL_(NSURL.URLWithString_("https://raw.github.com/andymatuschak/Sparkle/4d00e8c569933dc7576a7b501f3caea0f4d30737/SUModelTranslation.plist"))

for model in models:
    print "@\"%s\", @\"%s\"," % (models[model], model)