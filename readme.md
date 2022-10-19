### Requirements

The tests for this script are written using RSpec, so you’ll need to have this installed before being able to run the tests. You can install RSpec by running

```bash
gem install rspec -v 3.11.0
```

_Note that this will install the specific version of RSpec used for writing these tests._

#### Running the tests

Running the following command will run the tests for this project

```bash
rspec .
```

#### Running the script

```bash
ruby parser.rb webserver.log
```

Replace `webserver.log` with the path to any other log file. Note that log files must be in the format below in order to be processed:

```
[path] [ip address]
```

e.g.

```
/help_page/1 722.247.931.582
```

### Architecture

I've stored my initial notes [here](https://gist.github.com/maxshelley/5a98ee9d879a98abb905b88d1a4b2768) in case they're useful, and hopefully indicated my approach in the commit messages. With the limited time available, and opting to not attempt to use an external storage mechanism, I've used the `PathVisitDatastore` class as the storage location for the desired output data, with other classes serving to format, ingest, sort and output the relevant data. This hopefully provides enough flexibility to adjust these classes as needed as we introduce future changes.

### Reliability

I've added some basic validations here, mainly due to time constraints:

- Check whether a file exists at the given path
- Check that each log line conforms to the current number of columns

One issue, highlighted in the relevant commit message, is that we're using the path as a measure of a unique visit, so any URL params will be stored as a new visit, we might want to exclude these.

Some additional checks we could perform:

- Check for valid URL's and IP's in the log ingestion
- Make the code resilient against invalid log lines - rather than failing altogether, the code could log invalid lines and perhaps output them as warnings.

### Scalability

With the time constraints around writing this code, this script takes a pragmatic approach to scalability. Here are some considerations around the existing code:

- We’ve used `File.foreach` rather than loading the entire log file into memory.
- We're storing both the quantities of visits for each path and the unique IP addresses that visited the path in memory, so these will grow unbounded depending on the size of the log file. I've listed in the relevant commit messages where alternative approaches could be looked at: storing those values in a text file, a database, key-value store etc.
- The sorting of the result set is using Ruby's built-in `.sort_by` so we would want to benchmark and review whether that's the most performant mechanism for this (this point is dependent on the chosen data storage)

### Next steps

As a log parser, the primary next steps would likely be to deal with performance and data storage as discussed above.

In terms of features we could implement, the code could be updated to:

- Handle URL params and optionally treat them as unique URLs
- Handle more complex/verbose logs with more columns
