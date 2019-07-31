# Contact2Sale

Project Contact2Sale.<br>

Part 1:<br>
resouces/insertionSort.rb<br>
<br>

Part 2:<br>

Heroku (Live Demo):<br>
https://contacttosale.herokuapp.com
(Email upload test for resouces/test_email_right.eml)

Command for you use:<br/>
$ sudo service postgresql start <br/>
$ cd contact_to_sale<br/>
$ bundle update<br/>
$ bundle install<br/>
$ rake db:drop db:create db:migrate<br/>
$ rails s or rails s -p $PORT -b $IP<br/>

Access your browser: http://0.0.0.0:8080 or http://localhost:8080<br/>

Ruby Version:<br/>
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin18]<br>

Rails Version:<br/>
Rails 5.2.3<br/>

PostGres Version :<br/>
(PostgreSQL) 11.3<br/>

Gem's used:<br/>
gem 'jquery-rails', '~> 4.3.3'<br/>
gem 'bootstrap', '~> 4.3.1'<br/>
gem 'jquery-datatables-rails', '~> 3.4.0'<br/>
gem 'httparty'<br/>
gem 'nokogiri'<br/>