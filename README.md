# cinms

Channel Islands National Marine Sanctuary (CINMS) - infographics

This website uses a simple interactive infographics implementation based on JavaScript only (ie not using the R-based [infographiq](https://github.com/marinebon/infographiq)).

## technical implementation

The illustration in scalable vector graphics (`.svg`) format has individual elements given an identefier (ie `id`) which are linked to popup (ie "modal") windows of content using a simple table in comma-seperated value (`.csv`) format using [d3](https://d3js.org).

### core files: `.svg`, `.csv`

These two files are at the core of the infographic construction:

1. **illustration**: [`cinms_pelagic.svg`](https://github.com/marinebon/cinms/blob/master/svg/cinms_pelagic.svg) 
1. **table**: [`svg_links.csv`](https://github.com/marinebon/iea-ak-info/blob/master/svg/svg_links.csv) 

Each `link` in the table per element identified (`id`) is the page of content displayed in the modal popup window when the given element is clicked. The `title` determines the name on hover and title of the modal window.

### editing the svg

Open the `*.ai` file in Adobe Illustrator. Ensure the layer is given the `svg_id`. File > Export... as SVG using these parameters:

![](img/adobe-illustrator_export-as-svg_settings.png)

### html and js/css dependencies

The illustration (`.svg`) and table (`.csv`) get rendered with the `link_svg()` function (defined in `infographiq.js`) with the following HTML:

```html
<!-- load dependencies on JS & CSS -->
<script src='https://d3js.org/d3.v5.min.js'></script>
<script src='infographiq.js'></script>

<!-- add placeholder in page for placement of svg -->
<div id='svg'></div>

<!-- run function to link the svg -->
<script>link_svg(svg='svg/cinms_pelagic.svg', csv='svg/svg_links.csv');</script>
```

The modal popup windows are rendered by [Bootstrap modals](https://getbootstrap.com/docs/3.3/javascript/#modals). This dependency is included with the default Rmarkdown rendering, but if you need to seperately include it then add this HTML:

```html
<!-- load dependencies on JS & CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
```

### Use with Rmarkdown

The most common use of this is with an [Rmd website](https://bookdown.org/yihui/rmarkdown/rmarkdown-site.html). Then you can easily generate navigation throughout the website and then implement the infographics using a combination of [Rmd parameters](https://rmarkdown.rstudio.com/developer_parameterized_reports.html%23parameter_types%2F) and an [Rmd child document](https://yihui.org/knitr/demo/child/).

For example:

    ```
    ---
    title: "Pelagic"
    params:
      svg: "svg/cinms_pelagic.svg"
      csv: "svg/svg_links_cinms.csv"
    ---
    
    ```{r svg, child = '_svg-html_child.Rmd'}
    ```

So the infographic rendering is handled by the child doc [`_svg-html_child.Rmd`](https://github.com/marinebon/cinms/blob/master/_svg-html_child.Rmd) using the parameters `svg` and `csv`.


## build and view website in R

This website is constructed using [Rmarkdown website](https://bookdown.org/yihui/rmarkdown/rmarkdown-site.html) for enabling easy construction of site-wide navigation (see [`_site.yml`](https://github.com/marinebon/iea-ak-info/blob/master/_site.yml)) and embedding of [htmlwidgets](https://www.htmlwidgets.org), which provide interactive maps, time series plots, etc into the html pages to populate the modal window content in [`modals/`](https://github.com/marinebon/iea-ak-info/tree/master/modals). To build the website and view it, here are the commands to run in R:

## develop

### content editing workflow

1. Get the latest [`nms4r`](https://marinebon.org/nms4r/) library. Run once or if library gets updated.

```r
remotes::install_github("marinebon/nms4r")
```

2. Edit .Rmd files in `./docs/modals/`

NOTE: The `.html` files *can* be edited but by default `.html` files are overwritten by content knit from the `Rmd` files of the same name.

To use html directly set `redo_modals <- T`, but you will need to clear `.html` files manually with this setting.


3. Render the Rmarkdown files in the site and under modals/.

```r
# render only changed Rmds
infographiqR::render_all_rmd()

# render all Rmds
infographiqR::render_all_rmd(render_all = T)
```

### testing

Because of [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) restrictions, need local web server to debug and view the SVG scene in the rendered HTML:

```r
# build website
infographiqR::render_all_rmd()

# serve website locally
servr::httd(".")
```

or using Python:

```bash
cd ~/github/cinms/docs; python -m SimpleHTTPServer
```
