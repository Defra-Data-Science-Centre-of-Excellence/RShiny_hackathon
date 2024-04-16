# R Shiny on the DASH platform

Authors: Kate Hutchinson, Margarita Tsakiridou, Fluke Kasemsubphaisarn

[![Launch week logo](https://github.com/Defra-Data-Science-Centre-of-Excellence/RShiny_hackathon/blob/main/launch%20banner%20intranet%201.png)](https://defra.sharepoint.com/sites/Community448/SitePages/DASH-Launch-Week.aspx)

## 1. Introduction

Thank you for signing up to the DASH Hackathon! Here is some important information for the day:

-  We assume that you are already onboarded to the platform. If true, you should be able to access our [Playbook](https://dap-prd2-connect.azure.defra.cloud/DASH-Playbook/#content)

-  The point of this hackathon is to help you create a finished product on the DASH platfrom. We have prepared this example using a sample dataset but you are very welcome to use other datasets on the DASH platform or your own data to create your product.

## 2. Setting the scene

### 2.1 Resources

#### R Shiny guidance

There's a wealth of RShiny training materials online, as well as lots of other users. Google is great for finding the answer to most questions, particularly on stack overflow. Some useful resources for getting started are:

-  [Mastering Shiny](https://mastering-shiny.org/index.html)

-  [Shiny Basics](https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/index.html)

-  There are also great courses on datacamp. If you haven't already, sign up for a free premium account here: [Datacamp sign up link](https://www.datacamp.com/business/partners/Defra-and-datacamp-partnership)

#### Dashboarding guidance

-  [Analysis function: dashboards](https://analysisfunction.civilservice.gov.uk/policy-store/top-tips-for-designing-dashboards/)

### 2.2 Accessing RStudio & DASH data

-  To open RStudio on DASH please follow the instructions in the playbook: [Accessing RStudio](https://dap-prd2-connect.azure.defra.cloud/DASH-Playbook/rstudio.html)

-  If you haven't already set up git in R, you will need to do this before starting so that you can back up your code in a repository, see [Chapter 9 GitHub](https://dap-prd2-connect.azure.defra.cloud/DASH-Playbook/git.html#getting-set-up). If you're new to using git, there are [links to more resources on the use of GitHub](https://dap-prd2-connect.azure.defra.cloud/DASH-Playbook/git.html#uggithub).

-  [Chapter 6.4](https://dap-prd2-connect.azure.defra.cloud/DASH-Playbook/rstudio.html#rsdata) provides a detailed walkthrough on accessing data from RStudio. In the example app we have used the penguins dataset which can be found at this file path: /dbfs/mnt/lab/unrestricted/R_training/penguins.csv

-  NOTE: the posit server cannot see the datalake, so you will need to load your data from the datalake and save it in a data folder within your project. Before doing this ensure to add your data folder to your [gitignore file](https://git-scm.com/docs/gitignore), as best practice is to not save any data on GitHub. 

## 3. Developing a product

We have created an R Shiny app with the penguins dataset as an example you can refer to if you're struggling to get started. There are comments explaining what each part of the code is doing. 

If you want to use this to get started, here are some possible next steps you could take to further develop the dashboard:

-  populate the pages for the other penguin species

-  add another input for sex, see [different types of inputs](https://mastering-shiny.org/basic-ui.html)

-  use CSS to style your dashboard: [Using custom CSS in your app](https://shiny.posit.co/r/articles/build/css/), [CSS for Shiny](https://unleash-shiny.rinterface.com/beautify-css)

-  there are other ways you can add themes to your dashboard too, see chapters on [Bootstrap](https://mastering-shiny.org/action-layout.html#bootstrap) and [Themes](https://mastering-shiny.org/action-layout.html#themes)

-  For bigger dashboards, organising your code into functions and modules will make the app more efficient. See [Best practices](https://mastering-shiny.org/scaling-intro.html) for more information


## 4. Next steps

### 4.1 Publishing

Instructions on publishing from RStudio to the Posit server: [Chapter 6 Posit Connect Server](https://dap-prd2-connect.azure.defra.cloud/DASH-Playbook/positconnect.html#ugrsc). Once published the default is that your dashboard will only be visible to you. On posit you can control who to share your dashboard with. 

### 4.2 Advertising

We hope you enjoyed spending the day on the DASH platform and we hope to see you again soon. We would be very keen to invite you to our next Data Science Session (17th May; please sign up [here](https://defra.sharepoint.com/sites/Community448/SitePages/Discussion-Sessions-(Coffee-and-Coding).aspx) to receive invites) to share your experience and work with more colleagues that are currently being onboarded to the DASH platform. 

# 5 Useful links
## DASH
- [DASH Sharepoint page](https://defra.sharepoint.com/sites/Community448/SitePages/Welcome-to-the-Data-Science-Centre-of-Excellence.aspx)
- [DASH SharePoint](https://defra.sharepoint.com/sites/Community448/SitePages/Welcome-to-the-Data-Science-Centre-of-Excellence.aspx)
- Sign up to our [Data Science Sessions](https://defra.sharepoint.com/sites/Community448/SitePages/Discussion-Sessions-(Coffee-and-Coding).aspx)
- Please get in touch with [datascience@defra.gov.uk](mailto:datascience@defra.gov.uk) if you have any questions or suggestions.

## RShiny

- [Mastering Shiny](https://mastering-shiny.org/index.html)
- [Shiny Basics](https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/index.html)
- [Analysis function: dashboards](https://analysisfunction.civilservice.gov.uk/policy-store/top-tips-for-designing-dashboards/)
- [Setting UP Git](https://dap-prd2-connect.azure.defra.cloud/DASH-Playbook/git.html#getting-set-up)
- [GitHub resources](https://dap-prd2-connect.azure.defra.cloud/DASH-Playbook/git.html#uggithub)
- [gitignore file](https://git-scm.com/docs/gitignore)
- [different types of inputs](https://mastering-shiny.org/basic-ui.html)
- [Using custom CSS in your app](https://shiny.posit.co/r/articles/build/css/) 
- [CSS for Shiny](https://unleash-shiny.rinterface.com/beautify-css)
- [Bootstrap](https://mastering-shiny.org/action-layout.html#bootstrap)
- [Themes](https://mastering-shiny.org/action-layout.html#themes)
- [Best practices](https://mastering-shiny.org/scaling-intro.html)
- [Publishing on Posit Connect Server](https://dap-prd2-connect.azure.defra.cloud/DASH-Playbook/positconnect.html#ugrsc)
