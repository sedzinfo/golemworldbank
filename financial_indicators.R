##########################################################################################
# LOAD
##########################################################################################
rm(list=ls())
cat("\014")
graphics.off()
directory<-paste0(dirname(rstudioapi::getActiveDocumentContext()$path),"/")
# download.file("https://databank.worldbank.org/data/download/WDI_CSV.zip",
#               paste0(directory,"data/WDI_CSV.zip"),
#               method="libcurl",quiet=FALSE,mode="w",
#               cacheOK=FALSE,extra=getOption("download.file.extra"),headers=NULL)
unzip(zipfile=paste0(directory,"data/WDI_CSV.zip"),
      exdir=paste0(directory,"data/"),
      files=c("WDICSV.csv"),list=FALSE,overwrite=TRUE,junkpaths=FALSE,
      unzip="internal",setTimes=FALSE)
df_wdi<-read.csv(paste0(directory,"data/WDICSV.csv"),
                 stringsAsFactors=FALSE,
                 check.names=FALSE,
                 na.strings="")
country_code<-read.csv(paste0(directory,"data/WDICountry.csv"),
                       stringsAsFactors=FALSE,
                       check.names=FALSE,
                       na.strings="")
##########################################################################################
# BARPLOTS
##########################################################################################
indicator_code<-unique(df_wdi[,c("Indicator Name","Indicator Code")]) # for INDICATOR INFO below
df_wdi$`Indicator Code`<-NULL
df_wdi<-df_wdi[!is.nan(as.numeric(rowMeans(df_wdi[,grep("^\\d{4}$",names(df_wdi))],na.rm=TRUE))),]
mdf<-reshape::melt(df_wdi,
                   id.vars=c("Country Name","Country Code","Indicator Name"),
                   variable_name="Year",
                   na.rm=TRUE)
mfi<-merge(country_code[,c("Country Code","Region")],
           mdf,
           by="Country Code",
           all=TRUE)
mfi<-mfi[complete.cases(mfi),]
mfi<-mfi[order(mfi$Year),]
# names in mfi = names in country_code (so the Scatterplot finds their region)
rename<-c("Bolivia"="Bolivia, Plurinational State of",
          "Cote d'Ivoire"="Côte d'Ivoire",
          "Congo, Dem. Rep."="Congo, Democratic Republic of",
          "Congo, Rep."="Congo, Republic of",
          "Curacao"="Curaçao",
          "Egypt, Arab Rep."="Egypt, Arab Republic of",
          "Micronesia, Fed. Sts."="Micronesia, Federated States of",
          "Iran, Islamic Rep."="Iran, Islamic Republic of",
          "Korea, Rep."="Korea",
          "Naoero"="Nauru",
          "Korea, Dem. People’s Rep."="Korea, Democratic People’s Republic of",
          "Somalia, Fed. Rep."="Somalia",
          "Sao Tome and Principe"="São Tomé and Principe",
          "Turkiye"="Türkiye",
          "Venezuela, RB"="Venezuela, República Bolivariana de",
          "Virgin Islands (U.S.)"="Virgin Islands (US)",
          "Yemen, Rep."="Yemen, Republic of")
for(old in names(rename)) 
  mfi$`Country Name`[mfi$`Country Name`==old]<-rename[[old]]
##########################################################################################
# PYRAMID
##########################################################################################
mfi_population<-mfi[grep("Population ages",mfi$`Indicator Name`),]
mfi_population$sex<-mfi_population$unit<-mfi_population$age<-NA
mfi_population[grep(" female",mfi_population$`Indicator Name`),"sex"]<-"Female"
mfi_population[grep(" male",mfi_population$`Indicator Name`),"sex"]<-"Male"
mfi_population[grep(" total",mfi_population$`Indicator Name`),"sex"]<-"Total"
mfi_population[grep(" total",mfi_population$`Indicator Name`),"unit"]<-"Frequency"
mfi_population[grep(" female",mfi_population$`Indicator Name`),"unit"]<-"Frequency"
mfi_population[grep(" male",mfi_population$`Indicator Name`),"unit"]<-"Frequency"
mfi_population[grep(" of total population",mfi_population$`Indicator Name`),"unit"]<-"Percent"
mfi_population[grep(" of female population",mfi_population$`Indicator Name`),"unit"]<-"Percent"
mfi_population[grep(" of male population",mfi_population$`Indicator Name`),"unit"]<-"Percent"
mfi_population[grep(" 00-04",mfi_population$`Indicator Name`),"age"]<-"00-04"
mfi_population[grep(" 05-09",mfi_population$`Indicator Name`),"age"]<-"05-09"
mfi_population[grep(" 10-14",mfi_population$`Indicator Name`),"age"]<-"10-14"
mfi_population[grep(" 15-19",mfi_population$`Indicator Name`),"age"]<-"15-19"
mfi_population[grep(" 20-24",mfi_population$`Indicator Name`),"age"]<-"20-24"
mfi_population[grep(" 25-29",mfi_population$`Indicator Name`),"age"]<-"25-29"
mfi_population[grep(" 30-34",mfi_population$`Indicator Name`),"age"]<-"30-34"
mfi_population[grep(" 35-39",mfi_population$`Indicator Name`),"age"]<-"35-39"
mfi_population[grep(" 40-44",mfi_population$`Indicator Name`),"age"]<-"40-44"
mfi_population[grep(" 45-49",mfi_population$`Indicator Name`),"age"]<-"45-49"
mfi_population[grep(" 50-54",mfi_population$`Indicator Name`),"age"]<-"50-54"
mfi_population[grep(" 60-64",mfi_population$`Indicator Name`),"age"]<-"60-64"
mfi_population[grep(" 65-69",mfi_population$`Indicator Name`),"age"]<-"65-69"
mfi_population[grep(" 70-74",mfi_population$`Indicator Name`),"age"]<-"70-74"
mfi_population[grep(" 75-79",mfi_population$`Indicator Name`),"age"]<-"75-79"
mfi_population[grep(" 80 and above",mfi_population$`Indicator Name`),"age"]<-"80+"
mfi_population[grep(" 0-14",mfi_population$`Indicator Name`),"age"]<-NA
mfi_population[grep(" 15-64",mfi_population$`Indicator Name`),"age"]<-NA
mfi_population[grep(" 65 and above",mfi_population$`Indicator Name`),"age"]<-NA
mfi_population$age<-factor(mfi_population$age,
                           levels=c("00-04","05-09","10-14",
                                    "15-19","20-24","25-29",
                                    "30-34","35-39","40-44",
                                    "45-49","50-54","60-64",
                                    "65-69","70-74","75-79",
                                    "80+"))
mfi_population<-mfi_population[complete.cases(mfi_population),]
mfi_population$`Country Code`<-mfi_population$Region<-NULL
mfi_population$`2-alpha code`<-mfi_population$`Indicator Code`<-NULL
row.names(mfi_population)<-NULL
##########################################################################################
# INDICATOR INFO
##########################################################################################
# Topic and definition of each indicator, for the Index tab. Joined on the code,
# not the name: WDISeries.csv words ~100 names differently from WDICSV.csv
# ("Adjusted savings, ..." vs "Adjusted savings: ...").
series<-read.csv(unz(paste0(directory,"data/WDI_CSV.zip"),"WDISeries.csv",encoding="UTF-8-BOM"),
                 stringsAsFactors=FALSE,
                 check.names=FALSE,
                 na.strings="")
indicator_info<-indicator_code[indicator_code$`Indicator Name`%in%mfi$`Indicator Name`,]
indicator_info<-merge(indicator_info,
                      series[,c("Series Code","Topic","Short definition")],
                      by.x="Indicator Code",
                      by.y="Series Code",
                      all.x=TRUE)
names(indicator_info)[names(indicator_info)=="Short definition"]<-"Definition"
indicator_info$`Indicator Code`<-NULL
indicator_info<-indicator_info[order(indicator_info$`Indicator Name`),]
row.names(indicator_info)<-NULL
##########################################################################################
# SAVE
##########################################################################################
mfi$Region<-NULL
# mfi<-mfi[as.numeric(as.character(mfi$Year))>=1990,]
mfi$Year<-droplevels(mfi$Year)
row.names(mfi)<-NULL

save(mfi,file=paste0(directory,"data/mfi.rda"),version=3)
save(country_code,file=paste0(directory,"data/country_code.rda"),version=3)
save(mfi_population,file=paste0(directory,"data/mfi_population.rda"),version=3)
save(indicator_info,file=paste0(directory,"data/indicator_info.rda"),version=3)

# rwf::cdf(mfi)
# rwf::cdf(mfi_cor)
# rwf::cdf(mfi_population)
