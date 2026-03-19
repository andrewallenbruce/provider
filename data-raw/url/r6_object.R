account <- function(total) {
  list(
    balance = function() {
      total
    },
    deposit = function(amount) {
      total <<- total + amount
    },
    withdraw = function(amount) {
      total <<- total - amount
    }
  )
}

Robert <- account(1000)
Robert$balance()
Robert$deposit(1000000)
Robert$withdraw(150)
Robert$balance()

Ross <- account(500)
Ross$balance()

get_uuid("providers")

inquiry <- function() {
  list(
    url = function() {
      URL
    },
    uuid = function(endpoint) {
      URL <<- gsub("<<uuid>>", get_uuid(endpoint), get_uri(endpoint))
    },
    total = function(type) {
      gsub(
        "<<end>>",
        switch(type, rows = "/stats?", bare = "?offset=0&size=10"),
        URL,
        fixed = TRUE
      )
    },
    count = function(query) {
      paste0(gsub("<<end>>", "/stats?", URL, fixed = TRUE), query)
    },
    mark = function() {
      URL <<- gsub("<<end>>", "?", URL, fixed = TRUE)
    },
    final = function(query) {
      paste0(URL, query, collapse = "&")
    }
  )
}

x <- inquiry()
x$uuid(endpoint = "providers")
x$url()
x$total(type = "rows")
x$total(type = "bare")
x$count(query = "PROVIDER_TYPE_CODE=00-12")
x$mark()
x$final(query = "PROVIDER_TYPE_CODE=00-12")

cms <- list(
  uri = "https://data.cms.gov/data-api/v1/dataset/<<uuid>>/data<<end>>",
  uid = "2457ea29-fc82-48b0-86ec-3b0755de7515",
  end = list(stats = "/stats?", qmk = "?"),
  opt = list(size = 10, offset = 0)
)

prov <- list(
  uri = "https://data.cms.gov/provider-data/api/1/datastore/query/<<uuid>>/0?",
  uid = "mj5m-pzi6",
  opt = "schema=false&keys=true&format=json&rowIds=false&count=true&",
  results = "true",
  offset = 0,
  limit = 10
)
