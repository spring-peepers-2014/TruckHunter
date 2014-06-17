# Comments

1.  Thank you so much for having a working app that we were able to get up and
running in a matter of minutes.  Yours is the level of professionalism we
expect.
2.  On an initial install and execte of your `root_route` I make queries to
Twitter but, since I don't have creds, I get errors logged in the console.
Maybe you should put in your README that that's an expectation **and** you
should handle that error better.  It's time to use `begin...rescue...end`.
3. Your tests, while I'm glad they exist, don't run because you're missing a
thing called `HomeController`.  Wtf.
  * Your tests are using old and deprecated syntax, I get warning when I run rspec
4.  I see that you have a `CLIENT` constant.  I think you're reaching for a
design pattern called the Singleton:  you want a model to create an instance of
a thing (`Twitter::REST::Client.new`) but you want there only ever to be one of
them, that's a Singleton.  We can fix that.  The problem is because you didn't
define one for your test environment, I can't run your tests :(  The fact that
I can't run the tests and that your `HomeController` was blowing up your tests
indicates to me you're not doing TDD.
5.  
