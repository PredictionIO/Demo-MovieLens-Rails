# MovieLens Rails Demo

[![Dependency Status](https://gemnasium.com/PredictionIO/Demo-MovieLens-Rails.svg)](https://gemnasium.com/PredictionIO/Demo-MovieLens-Rails)

Built with: [PredictionIO](http://prediction.io).


## Fast Import

PostgreSQL dump: http://download.prediction.io/demos/movielens-rails/movielens-demo.dump

## Slow Import

You can download the [MoiveLens](http://grouplens.org/datasets/movielens/) data and place the unzipped files into the `data` directory. After that you can run:

```
$ rake import:movies
$ rake import:ratings
$ rake import:imdb_search
$ rake import:imdb_fields
```

The entire import processes takes about 24 hours. There is also some manual cleanup to the PostgreSQL data so I **highly recomend** using the PosgreSQL dump instead. Rake tasks are mostly just for documentation.

## Environmental Variables

```
PIO_EVENT_SERVER_URL=http://localhost:7070
PIO_ENGINE_URL=http://localhost:8000
PIO_ACCESS_KEY=<YOUR_ACCESS_KEY>
```
