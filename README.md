# Scraper

This is a scraper for books from [Book Depository](https://www.bookdepository.com/) in order to get the results which are currently available and on the next stage would like to add a price following functionality - if desired price range is met, a notice is sent through email.

## Screenshot

![Screenshot of the webpage](https://github.com/Jaakal/scraper/blob/set_up_scraper/screenshot.png)

## Getting Started

First you'll have to install Ruby into your computer. Then you'll need to download project into your computer and open up the terminal in project root directory. Then you'll have to run bundle install and have a little luck with all the gems installing without problems. Then you'll have to run the command "ruby application_controller.rb" and open up browser on "localhost:4567". Instructions, how to use the scraper, is provided through GUI in browser as is visible from the screenshot.

## Rspec tests

There's six tests over all, which test that the connection with Book Depository webpage is set up and all the functions work in order to get the desired search results or no error is thrown if for the result is no books at all.

## Deployment

Work in progress to get it set up in Heroku!

## Built With

* [Ruby](http://www.dropwizard.io/1.0.2/docs/) - Programming language used
* [JavaScript](https://www.javascript.com/) - Programming language used
* [HTML](https://html.com/) - Programming language used
* [CSS](https://www.w3schools.com/css/css_intro.asp) - Programming language used
* [VS Code](https://maven.apache.org/) - Code editor used

## Authors

👤 **Jaak Kivinukk**

- Github: [Jaakal](https://github.com/Jaakal)
- Twitter: [@JKivinukk](https://twitter.com/JKivinukk)
- Linkedin: [Jaak Kivinukk](https://www.linkedin.com/in/jaak-kivinukk-7098b1153/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Shout out to Sagun Shrestha and his article [Web Scraping Project Ideas](https://medium.com/etllab/web-scraping-project-ideas-50de5d21947) for giving me ideas for the scraper project
