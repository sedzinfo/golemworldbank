# Country and region reference table

Reference metadata mapping each country to its region, income group, and
other World Bank classification metadata.

## Usage

``` r
country_code
```

## Format

A data frame with 265 rows and 31 columns, including `Country Code`,
`Short Name`, `Table Name`, `Long Name`, `Region`, and `Income Group`.

## Source

World Bank Open Data (<https://data.worldbank.org>).

## Examples

``` r
# \donttest{
head(country_code)
#>   Country Code                  Short Name                  Table Name                    Long Name 2-alpha code  Currency Unit
#> 1          ABW                       Aruba                       Aruba                        Aruba           AW  Aruban florin
#> 2          AFE Africa Eastern and Southern Africa Eastern and Southern  Africa Eastern and Southern           ZH           <NA>
#> 3          AFG                 Afghanistan                 Afghanistan Islamic State of Afghanistan           AF Afghan afghani
#> 4          AFW  Africa Western and Central  Africa Western and Central   Africa Western and Central           ZI           <NA>
#> 5          AGO                      Angola                      Angola  People's Republic of Angola           AO Angolan kwanza
#> 6          ALB                     Albania                     Albania          Republic of Albania           AL   Albanian lek
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Special Notes
#> 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               <NA>
#> 2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 26 countries, stretching from the Red Sea in the North to the Cape of Good Hope in the South (https://www.worldbank.org/en/region/afr/eastern-and-southern-africa)
#> 3 The reporting period for national accounts data is designated as either calendar year basis (CY) or fiscal year basis (FY). For this country, it is fiscal year-based (fiscal year-end: March 20). Also, an estimate (PA.NUS.ATLS) of the exchange rate covers the same period and thus differs from the official exchange rate (CY).\n\nIn addition, the World Bank systematically assesses the appropriateness of official exchange rates as conversion factors. In this country, multiple or dual exchange rate activity exists and must be accounted for appropriately in underlying statistics. An alternative estimate (“alternative conversion factor” - PA.NUS.ATLS) is thus calculated as a weighted average of the different exchange rates in use in the country. Doing so better reflects economic reality and leads to more accurate cross-country comparisons and country classifications by income level. For this country, this applies to the period 1960-2006. Alternative conversion factors are used in the Atlas methodology and elsewhere in World Development Indicators as single-year conversion factors.
#> 4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                22 countries, stretching from the westernmost point of Africa, across the equator, and partly along the Atlantic Ocean till the Republic of Congo in the South (https://www.worldbank.org/en/region/afr/western-and-central-africa)
#> 5                                                                                                                                                                                                                                                                                                                                                       The World Bank systematically assesses the appropriateness of official exchange rates as conversion factors. In this country, multiple or dual exchange rate activity exists and must be accounted for appropriately in underlying statistics. An alternative estimate (“alternative conversion factor” - PA.NUS.ATLS) is thus calculated as a weighted average of the different exchange rates in use in the country. Doing so better reflects economic reality and leads to more accurate cross-country comparisons and country classifications by income level. For this country, this applies to the period 1994-2024. Alternative conversion factors are used in the Atlas methodology and elsewhere in World Development Indicators as single-year conversion factors.
#> 6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               <NA>
#>                                              Region        Income Group WB-2 code                        National accounts base year National accounts reference year               SNA price valuation
#> 1                         Latin America & Caribbean         High income        AW                                               2013                               NA Value added at basic prices (VAB)
#> 2                                              <NA>                <NA>        ZH                                               <NA>                               NA                              <NA>
#> 3 Middle East, North Africa, Afghanistan & Pakistan          Low income        AF                                               2016                               NA Value added at basic prices (VAB)
#> 4                                              <NA>                <NA>        ZI                                               <NA>                               NA                              <NA>
#> 5                                Sub-Saharan Africa Lower middle income        AO                                               2002                               NA Value added at basic prices (VAB)
#> 6                             Europe & Central Asia Upper middle income        AL Original chained constant price data are rescaled.                             2020 Value added at basic prices (VAB)
#>   Lending category Other groups                                   System of National Accounts Alternative conversion factor PPP survey year Balance of Payments Manual in use
#> 1             <NA>         <NA> Country uses the 1993 System of National Accounts methodology                            NA              NA                              BPM6
#> 2             <NA>         <NA>                                                          <NA>                            NA              NA                              <NA>
#> 3              IDA         HIPC Country uses the 2008 System of National Accounts methodology                            NA              NA                              BPM6
#> 4             <NA>         <NA>                                                          <NA>                            NA              NA                              <NA>
#> 5             IBRD         <NA> Country uses the 1993 System of National Accounts methodology                            NA              NA                              BPM6
#> 6             IBRD         <NA> Country uses the 2008 System of National Accounts methodology                            NA              NA                              BPM6
#>   External debt Reporting status      System of trade   Government Accounting concept                     IMF data dissemination standard Latest population census
#> 1                           <NA> General trade system                            <NA> Enhanced General Data Dissemination System (e-GDDS)          2020 (expected)
#> 2                           <NA>                 <NA>                            <NA>                                                <NA>                     <NA>
#> 3                       Estimate General trade system Consolidated central government Enhanced General Data Dissemination System (e-GDDS)                     1979
#> 4                           <NA>                 <NA>                            <NA>                                                <NA>                     <NA>
#> 5                         Actual General trade system    Budgetary central government Enhanced General Data Dissemination System (e-GDDS)                     2014
#> 6                         Actual Special trade system Consolidated central government Enhanced General Data Dissemination System (e-GDDS)                     2023
#>                       Latest household survey      Source of most recent Income and expenditure data Vital registration complete Latest agricultural census Latest industrial data Latest trade data
#> 1                                        <NA>                                                   <NA>                         Yes                       <NA>                     NA              2018
#> 2                                        <NA>                                                   <NA>                        <NA>                       <NA>                     NA                NA
#> 3 Multiple Indicator Cluster Survey 2022-2023             Integrated household survey (IHS), 2016/17                        <NA>                       <NA>                     NA              2018
#> 4                                        <NA>                                                   <NA>                        <NA>                       <NA>                     NA                NA
#> 5       Demographic and Health Survey 2015/16             Integrated household survey (IHS), 2008/09                        <NA>                       <NA>                     NA              2018
#> 6   Demographic and Health Survey 2017 - 2018 Living Standards Measurement Study Survey (LSMS), 2012                         Yes                       2012                   2013              2018
#>   Latest water withdrawal data
#> 1                           NA
#> 2                           NA
#> 3                           NA
#> 4                           NA
#> 5                           NA
#> 6                           NA
# }
```
