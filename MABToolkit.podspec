Pod::Spec.new do |s|
  s.name         = "MABToolkit"
  s.version      = "1.0.3"
  s.summary      = "Reusable categories and classes for developing Cocoa applications"
  s.description  = <<-DESC
                  Main functionality:

                   * Managing + creating your app's support folder
                   * NSTableView+MABTableViewSizing - class for easily resizing a table's columns to fit available width
                   * Helpful macros for managing preferences, checking for empty values, and other misc tasks
                   * Implementation of the Levenshtein string distance algorithm as a NSString category
                   * Simple contains (case and non-case sensitive) boolean functions for NSString
                   * NSSplitView with divider image
                   * A combination of the old CPSystemInformation class and Sparkle's system profiler. Self-contained and allows for the retrieval of some additional information that Sparkle does not allow for.
                   DESC
  s.homepage     = "https://github.com/iloveitaly/MABCocoaToolkit"
  s.license      = "MIT"
  s.author             = { "Michael Bianco" => "info@cliffsidedev.com" }
  s.social_media_url   = "http://twitter.com/mike_bianco"

  s.platform     = :osx
  s.source       = { :git => "https://github.com/iloveitaly/MABCocoaToolkit.git", :tag => "1.0.3" }
  s.source_files = '*.{h,m}'
  s.frameworks = ['SystemConfiguration', 'IOKit']
  s.requires_arc = false
end
