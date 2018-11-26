## youtube video to mp3 convert
Searches youtube for a specific keyword based on some search filters provided and saves the resulting video urls as csv file locally.

* rvm (rvm.io)
* ruby interpreter (2.0+)
* required gems (see Gemfile)
* linux terminal

Setup usage with rvm and process event series:
* create a gemset
`$ rvm gemset create <gemset>`
eg. `$ rvm gemset create cryptology`
* use created gemset
`$ rvm <ruby version>@<gemset>`
* install bundler gem
`$ gem install bundler`
* install necessary gems
`$ bundle`
* make scripts executable
`$ chmod +x <script_name.rb>`
* run script
`$ ./<script_name.rb>`

Further Development [coming soon...]
* add various search filters such as publishDate etc...
* integrate with youtube-dl to change video url to mp3 ...
