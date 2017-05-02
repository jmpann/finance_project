# README
<snippet>
  <content><![CDATA[
# ${1:Find ETF Data}
Live Site: https://finance-data-project.herokuapp.com/
This project shows tables and charts of different State Street Advisors SPDR ETF data pulled from https://us.spdrs.com/en. It shows three fund components: Top 10 Holdings by shares, Sector Allocation by percent, and Country Weight by percent. Some funds will not have Country Weights and thus will not be shown. 

## Installation
Use the following steps if you want to host it locally instead of use the live site.
1) In terminal: clone the repo, cd into the root directory, run bundle install. This installs the dependent libraries. 
2) Run rake db:migrate to set up the database. 
3) Start the server with the following command: rails s
4) Generally the site should be hosted at https:localhost.3000

## Usage
1) Sign up/Sign in
2) Enter a ticker symbol into the search bar.
3) You will be redirected to that ETF's show page if the ticker symbol can be found on the site. The search form will re-render with a flash notice if the ticker symbol could not be found.
4) Optionally download the data in CSV format.
5) Search page is unique to the user. It displays their 10 most recent searches by ticker symbol and date. These are hyperlinks to that ETF's show page. 

## Notes on CSV file
Here is a shortened example CSV file output:

name,amount
Apple Inc.,60640164
Microsoft Corporation,89330570

sector,weight(%)
Information Technology,22.51
Financials,14.09

country,weight(%)
United Kingdown, 45.6%
China, 25.45%

I designed the output this way to make it easier for a user to parse it into a workbook or with a scripting language. The logic is in the to_csv instance method of the Etf class. The Etf#Show action also had to be programmed to allow the .csv file format. Essentially, the download happens by clicking a button which redirects you to /etfs/:id.csv where the file will automatically download. 

## Notes on Scraping
The bulk of the Etf creation happens as class methods of the Scraper class. This is my first time doing web scraping in Ruby. I would appreciate feedback on better ways to organize the scraping related code. It is completely dependent on https://us.spdrs.com/en maintaining the same site organization, layout, and css tags. The ETFs will most likely be created with erroneous information if that site changes. It heavily relies on the ruby Nokogiri library to create an object representing the page. Then it searches for the specific css selectors where the data resides. This generally returns an array of Nokogiri objects representing the relevant fragments of the DOM for Top 10 Holdings, Sector Allocation, and Country Weight. Then the Scraper class iterates over the array of fragments to pull the relevant information to create a corresponding database record with. This lives in the scraper.rb file. 

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D


## Feedback
I love feedback. Always looking to learn and improve. Feel free to send me an email: josh.pann@gmail.com
]]></content>
  <tabTrigger>readme</tabTrigger>
</snippet>
