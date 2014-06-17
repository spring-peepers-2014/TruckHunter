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
5.  You have tests that are good, but you're ignoring them.  You've done
helpful work to help yourselves but are not benefitting from that work.  Your'e
like a waiter who gives great service the whole meal but then makes me wait 30
minutes to deliver the check.  You fall apart at the part of the transaction
WHERE I GIVE YOU MONEY and am THINKING ABOUT HOW YOU SERVED ME.  Whatever work
you did before, I'm now lensing through through the latest experience.
6.  You commented out the entire tweets controller spec?  Isabel, as team lead,
you need to make sure this stuff doesn't get committed into **your** master
branch.  Isabel, as a developer you need to not do stuff like that: it will
irritate your team lead.
7.  Testing:  Overall you're testing that ActiveRecord works.
8.  I love that you installed Jasmine, but when I try to run the tests, they
don't work.  The reason is because `route.rb` will not define that route unless
`JasmineRails` is defined (ln: 3).  It's not defined becasue it's not in your
Gemfile.  Now I'm wondering, "How were they running these tests?" and I'm
wondering "will any of them work after i debug their test runner?"
Well, I didn't have to wait long to get my answer.  After i fixed the spec
runner, I went to /specs and saw that you have most of your tests failing.  For
such a JavaScript heavy app you really should have tests with more
comprehensive coverage.
9.  You have no tests around the admin functionality.  That's where a lot of
your logic is.  If you were to test that well you could probably be assured of
a functional app.  TESTS.
