## youtube video to mp3 convert
![temporary logo](https://s2.gifyu.com/images/Peek-2018-10-29-00-13.gif "get_my_news temporary logo")


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
* create a folder api_keys
`$ mkdir api_keys`
* create a folder csv_files
`$ mkdir csv_files`
* make scripts executable
`$ chmod +x <script_name.rb>`
* run script
`$ ./<script_name.rb>`

Further Development [coming soon...]
* add various search filters such as publishDate etc...
* integrate with youtube-dl to download youtube videos from saved url in one go
