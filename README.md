# Ampparit data Miner

Ampparit is a Finnish news aggregation site. It has recent news and data about how many times a news item link has been clicked and how many likes/dislikes a news item has received.

Ampparit data miner mines this data and inserts it into a database. It consists of miner that digests the html and parses the necessary fields and db utility that inserts news items into local SQLite3 database.

The goal is to use this data to predict from a news headline how many clicks and likes it will get. This will be implemented with either neural network or regression model. The prediction part is very much a work in progress. Hopefully it will serve as a tool to predict Finnish clickbait links.
