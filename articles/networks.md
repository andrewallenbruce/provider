# Provider Networks

``` r
library(provider)
library(dplyr)
library(purrr)
library(stringr)
library(igraph)
library(tidygraph)
library(ggraph)
```

## Example: Edge Table

``` r
edge_table <- tribble(
  ~from,          ~to,             ~label,
  "Individual",   "Organization",  "Reassigns Benefits To",
  "Organization", "Individual",    "Accepts Reassignment From")

edge_table
```

    #> # A tibble: 2 × 3
    #>   from         to           label                    
    #>   <chr>        <chr>        <chr>                    
    #> 1 Individual   Organization Reassigns Benefits To    
    #> 2 Organization Individual   Accepts Reassignment From

## Example: Node Table

``` r
node_table <- tribble(
  ~name,            ~x,  ~y,
  "Individual",     1,    0,
  "Organization",   2,    0)

node_table
```

    #> # A tibble: 2 × 3
    #>   name             x     y
    #>   <chr>        <dbl> <dbl>
    #> 1 Individual       1     0
    #> 2 Organization     2     0

``` r
example <- graph_from_data_frame(
  d = edge_table,
  vertices = node_table,
  directed = TRUE)

example
```

    #> IGRAPH 3c7422b DN-- 2 2 -- 
    #> + attr: name (v/c), x (v/n), y (v/n), label (e/c)
    #> + edges from 3c7422b (vertex names):
    #> [1] Individual  ->Organization Organization->Individual

``` r
ggraph(example, layout = "manual", x = x, y = y) +
  geom_node_text(aes(label = name), size = 5) +
  geom_edge_arc(
    aes(label = label), 
                   angle_calc = 'none',
                   label_dodge = unit(2, 'lines'),
                   arrow = arrow(length = unit(0.5, 'lines')), 
                   start_cap = circle(4, 'lines'),
                   end_cap = circle(4, 'lines'),
    strength = 1) +
  theme_void() +
  coord_fixed()
```

![](networks_files/figure-html/unnamed-chunk-5-1.png)

## Provider Networks

``` r
williams <- reassignments("1346391299") |>
  mutate(
    provider     = str_glue("{first} {last}"),
    organization = str_squish(
      str_remove_all(
        str_to_title(organization), 
        regex("Llc|Inc| Pc|-|,+|\\.")))) |> 
  select(provider, 
         organization, 
         reassignments) |> 
  arrange(desc(reassignments))
```

    #> Error in `dplyr::mutate()`:
    #> ℹ In argument: `dplyr::across(dplyr::where(is.character), na_blank)`.
    #> Caused by error:
    #> ! object 'na_blank' not found

``` r
williams
```

    #> Error:
    #> ! object 'williams' not found

## `{tidygraph}`

``` r
will_tdgrph <- tidygraph::as_tbl_graph(williams, directed = FALSE)
```

    #> Error:
    #> ! object 'williams' not found

``` r
summary(will_tdgrph)
```

    #> Error:
    #> ! object 'will_tdgrph' not found

``` r
will_tdgrph
```

    #> Error:
    #> ! object 'will_tdgrph' not found

``` r
ggraph(will_tdgrph, "stress") + 
  geom_edge_link(
    end_cap = circle(0.5, 'mm'), 
    edge.width = 0.5, color = "grey") +
  geom_node_point(
    show.legend = FALSE, 
    alpha = 1, 
    color = 'steelblue',
    size = 2.5) + 
  geom_node_label(
    aes(label = name),
    repel = FALSE,
    size = 3,
    alpha = 0.85,
    label.r = unit(0.25, "lines"),
    label.size = 0.1,
    check_overlap = TRUE) +
  theme_graph(fg_text_colour = 'white')
```

    #> Error:
    #> ! object 'will_tdgrph' not found
