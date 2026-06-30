library(pillar)

x = c(
  1003826272,
  1013647569,
  1023473279,
  1083295638,
  1174270805,
  1225701881,
  1235702796,
  1255782751,
  1255877502,
  1275117269,
  1306500665,
  1548743511,
  1588817837,
  1689182859,
  1841008505,
  1841967825,
  1851713903,
  1861857013,
  1891355863,
  1891390084,
  1962116806,
  1982059275,
  1982296737,
  1992338701
)

x <- nppes(x)
x

### ==================================================
library(autodb)

nppes_1 <- join2(x$ind$basic, x$ind$location, "npi")

ind <- autodb(nppes_1)
ind
gviz <- gv(ind)
DiagrammeR::grViz(gviz)

deps <- discover(nppes_1, progress = TRUE)
deps <- normalise(deps, remove_avoidable = TRUE)
subschemas(deps)
keys(deps)
DiagrammeR::grViz(gv(deps))


schema <- synthesise(deps)
schema
show(schema)

schema <- autoref(schema)
show(schema)
