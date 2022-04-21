
<!-- README.md is generated from README.Rmd. Please edit that file -->

# FOSSILPOL: The workflow to process global palaeoecological pollen data

<!-- badges: start -->
<!-- badges: end -->

The goal of the **FOSSILPOL workflow** is to process multiple fossil
pollen sequences to create a comprehensive, standardized dataset
compilation, ready for multi-sequence and multi-proxy analyses. The
FOSSILPOL workflow is coded as an RStudio project (in the R
environment), which should be customised by the user for a specific
research project.

## Developed by

The FOSSILPOL workflow has been developed during the ERC project called
the “Humans on Planet Earth” (HOPE) team at the University of Bergen:

Ondřej Mottl, Vivian A. Felde, Alistair W.R. Seddon, Suzette G.A.
Flantua, Kuber P. Bhatta

## Current version of the FOSSILPOL project

The version of the FOSSILPOL workflow: 0.0.1 The version of the
Technical guide to FOSSILPOL: 0.0.1 The version of the R-fossilpol
package: 0.0.1

## Package website

More detailed information can be found on [FOSSILPOL
website](https://www.nicepng.com/png/detail/137-1379308_website-work-in-progress.png)

## Table of Contents

1.  [Project description](#desc)
2.  [Setup](#setup)
3.  [Cascade of scripts](#cascade)
4.  [Data inputs](#inputs)
5.  [Data storage and outputs](#data)
6.  [Descripton of individual steps](#steps)
7.  [Getting help](#help)
8.  [Collabortion](#colab)

## Genral information <a name="desc"></a>

<!-- NOTE by ONDRA: add many emojis from https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md -->

### Project structure

This project consists of several folders:file\_folder:, with the
simplified structure visualised below. The full project structure can be
found on [FOSSILPOL
website](https://www.nicepng.com/png/detail/137-1379308_website-work-in-progress.png).

Through the text emotes will be used to specify **folder/s**
(:file\_folder:), a single **R script** (:page\_facing\_up:), and
multiple **R scripts** (:bookmark\_tabs:)

The main components of project directory are the **R project**
(`Workflow_template.Rproj`), `Data` :file\_folder:, and `R`
:file\_folder:, which stores all :bookmark\_tabs:.

Within the `R` :file\_folder:, this template consists of three main
parts: **Data processing** (`01_Data_processing`:file\_folder:), **Main
analyses** (`02_Main_analyses`:file\_folder:), and **Supplementary
analyses** (`03_Supplementary_analyses`:file\_folder:). This workflow
focuses on the first section only and the latter two are up for a user
to create, based on the project.

    project
    │   
    │   README.md
    │   Workflow_template.Rproj
    │
    └───Data
    │
    └───R
        │   ___Init_project___.R
        │   00_Config_file.R
        │   00_Master.R
        │
        └───01_Data_processing
        │   │
        │   └───01_Neotoma_source
        │   │   
        │   └───02_Private_source
        │   │
        │   └───03_Merging_and_geography
        │   │
        │   └───04_Chronologies
        │   │
        │   └───05_Harmonisation
        │   │
        │   └───06_Main_filtrering.R
        │   │
        │   └───07_Outputs       
        │
        └───02_Main_analyses
        │
        └───03_Supplementary_analyses

## Setup <a name="setup"></a>

### How to obtain

There are multiple ways for a user to create their own project using
this workflow template.

1.  If a user has a GitHub account, the easiest way is to create his/her
    own GitHub repo using this GitHub template. More detail about how to
    use GitHub templates on [GitHub
    Docs](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)

2.  A user can also obtain the newest release of the workflow from
    [ZENODO](https://www.nicepng.com/png/detail/137-1379308_website-work-in-progress.png)

### How to setup

Once a user obtains their own version of workflow, there are several
steps, which are needed to be done before using it.

1.  :white\_check\_mark:Update *R* and *R-studio*. There are many guides
    to do so
    (e.g. [here](https://jennhuck.github.io/workshops/install_update_R.html))

2.  :white\_check\_mark:Execute all individual steps with the
    `___Init_project___.R`:page\_facing\_up:. This will result in the
    preparation of all packages using the `renv` package:package:, which
    is R dependency management to your projects (more info about `renv`
    [here](https://rstudio.github.io/renv/articles/renv.html)).

3.  :white\_check\_mark:Set up your preferences by editing
    `00_Config_file.R`:page\_facing\_up:. The *Config file*, is
    :page\_facing\_up:, where all settings and criteria, used throughout
    the project, are defined. In addition, it also prepares the current
    session by loading the required packages and saving all settings
    throughout the project. The points of focus for a user are flagged
    using `[USER]`:triangular\_flag\_on\_post: note. The crucial points
    are:

    -   `data_storage_path` within *section 4.* - As the workflow is
        producing several large files, a user can specify the directory,
        where such files will be placed. Note that the default place is
        within the project.
    -   *section 5.* - There are many variables important for data
        selection and filtration of the final data assembly.

4.  :white\_check\_mark:Run
    `R/01_Data_processing/Master_run_01.R`:page\_facing\_up: to run the
    whole data processing part of project (be ready for
    [“stop-checks”](#stopchecks)). Alternatively, the user can run each
    script individually. After all “stop-check” are resolved, this would
    produce the standardized dataset compilation, ready for
    multi-sequence and multi-proxy analyses.

5.  :white\_check\_mark:Add additional project-specific :bookmark\_tabs:
    in `02_Main_analyses`:file\_folder: and
    `03_Supplementary_analyses`:file\_folder: to analyse the data
    compilation.

### “Stop-checks” <a name="stopchecks"></a>

Through the workflow, there will be several times, when a user will be
asked to adjust some CSV files and then continue with the workflow
(re-run :bookmark\_tabs:). This is done because the workflow is
producing files based on the preferred settings and a user has to
specify his/her preferences. For example, at a certain point, the
workflow will produce a list of all *ecological groups* detected within
the data assembly obtained from *Neotoma*. A user then has to edit the
mentioned CSV file and mark, which *ecological groups* should be kept
and which should be filtered out. This needs to be done only once for
each “stop-check”.

## Cascade of R scripts <a name="cascade"></a>

This workflow is constructed using a
*script-cascade*(:page\_facing\_up::arrow\_right::page\_facing\_up:).

That means that the `Master_run_01.R`:page\_facing\_up:, located within
`R/01_Data_processing/` :file\_folder:, executes **all**
:bookmark\_tabs: within sub-:file\_folder: of `R01_Data_processing/`
:file\_folder:. Those :bookmark\_tabs:, which in turn, execute **all**
their sub-:file\_folder:
(e.g. `R/01_Data_processing/01_Neotoma_source/Run_01_01.R`:page\_facing\_up:
executes
`R/01_Data_processing/01_Neotoma_source/01_Download_neotoma.R`:page\_facing\_up:,
`R/01_Data_processing/01_Neotoma_source/02_Extract_samples.R`:page\_facing\_up:,
…).

    R
    │
    └───01_Data_processing
            │
            │   Master_run_01.R
            │
            └───01_Neotoma_source
                │
                │   Run_01_01.R
                    │
                    │   01_Download_neotoma.R
                    │   02_Extract_samples.R
                    │   03_Filter_dep_env.R
                    │   04_Extract_chron_control_tables.R
                    │   05_Extract_raw_pollen_data.R

Therefore, a user can run the data processing section of the project
executing `R/01_Data_processing/Master_run_01.R`:page\_facing\_up:, or
run individual sections by executing individual :bookmark\_tabs: within
sections. However, it is recommended to run the workflow subsection as a
whole.

## Data inputs <a name="inputs"></a>

The Workflow is set up in a way that data from Neotoma is the primary
data. However, additional data sources (`private`) can be used in
parallel by using our predefined format (see section Data sourcing). The
user thus has the flexibility to either source data from Neotoma or
another data source if the consistent formatting file is used.

Three additional data inputs are required for the initial set-up of the
Workflow:

-   Configuration file (`00_Config_file.R`) – The configuration file
    contains all the user-selected settings which will be applied
    throughout the Workflow. These range from technical settings
    (e.g. location of the data storage) to specific requirements
    (e.g. filtering criteria) for sequences to be included.

-   Geographical shapefiles – Several shapefiles, which define the
    geographical information and harmonisation region for each sequence,
    must be provided by the user. Firstly, the Workflow is
    conceptualised for a global project, so the general structure of
    data processing is done “per continent”, but the user can use any
    other regionalization of interest. The Workflow comes with a default
    shapefile roughly delimiting continents, but it can be adjusted or
    replaced to fit project needs. Secondly, we provide a
    `harmonisation region shapefile` which is a copy of the continental
    regions by default, but we strongly recommend adjusting the
    harmonisation regions for each specific project and working on
    corresponding taxonomic harmonisation tables. Finally, any other
    geographical information can also be added for each sequence as long
    as shapefiles are provided.

-   Harmonisation tables – In each project, one harmonisation table must
    be provided per each harmonisation region (delimited by the
    corresponding harmonisation region shapefile, see above). A
    harmonisation table must have two columns: i) `original taxa` with
    taxonomic names originally present in Neotoma (and other data
    sourced in the project), and ii) `harmonised taxa` with the final
    taxonomic names. The Workflow will detect if a harmonisation table
    has been provided by the user, or otherwise create a new table with
    all detected “raw” taxa names for each harmonisation region. The
    latter can consequently serve as a template to create harmonisation
    of the `harmonised taxa` column.

## Data storage and outputs <a name="data"></a>

The Workflow will produce several files including temporal output files,
“stop-check” tables, and outputs (figures, data assembly, etc):

1.  Temporal output files: The Workflow is set up in a way that temporal
    (in-progress) data files are saved at various stages of the
    Workflow. Each file will contain the date of creation for easier
    organisation. When run multiple times, the Workflow will
    automatically detect if there are any changes in a selected file and
    only overwrite it if an updated file can be produced. This also
    means that the user does not have to re-run the whole Workflow but
    can only re-run specific parts. As the total size of the files can
    become substantially large, the user can specify if all files should
    be stored within the project folder (default) or in another
    directory (specified in using `data_storage_path` in Config file).
    After such specification, and running the `00_Config_file.R` script,
    there will be an additional folder structure created (see below).

2.  “Stop-checks” CSV tables (Supplementary Figure 1): While running the
    workflow, there will be several times that a user will be asked to
    check and where necessary adjust produced CSV tables to subsequently
    continue with the Workflow (i.e. re-run script). This is done so
    that the user is obliged to check produced intermediate results
    before continuing. For example, at a certain point, the Workflow
    will produce a list of all ecological groups detected within the
    dataset compilation obtained from Neotoma. A user then has to edit
    the mentioned CSV table and specify which ecological groups should
    be kept (include = TRUE) and which should be filtered out (include =
    FALSE). There are several stop-checks throughout the workflow
    (Supplementary Figure 1)

3.  Workflow final outputs:

    -   a ready-to-use, taxonomically harmonised and standardised
        compilation of fossil pollen data, ready for the analytical
        stage
    -   Age-depth model of each sequence
    -   Pollen diagram of each sequence
    -   A metadata table listing the main data contributor, contact
        information, and corresponding publications for citation
        purposes of the used datasets.

<!-- -->

    data_storage_path
    │
    └───Data
    │   │
    │   └───Input
    │   │   │
    │   │   └───Chronology_setting
    │   │   │   │
    │   │   │   └───Bchron_crash
    │   │   │   │
    │   │   │   └───Chron_control_point_types
    │   │   │   │
    │   │   │   └───Percentage_radiocarbon
    │   │   │
    │   │   └───Depositional_environment
    │   │   │   │
    │   │   │   └───Neotoma
    │   │   │   │
    │   │   │   └───Other
    │   │   │
    │   │   └───Eco_group
    │   │   │
    │   │   └───Harmonisation_tables
    │   │   │
    │   │   └───Neotoma_download
    │   │   │
    │   │   └───Potential_duplicates
    │   │   │
    │   │   └───Private
    │   │   │
    │   │   └───Regional_age_limits
    │   │   
    │   └───Personal_database_storage
    │   │
    │   └───Processed
    │       │
    │       └───Chronology
    │       │   │
    │       │   └───Chron_tables_prepared
    │       │   │
    │       │   └───Model_full
    │       │   │
    │       │   └───Predicted_ages
    │       │   │
    │       │   └───Temporary_output
    │       │
    │       └───Data_filtered
    │       │
    │       └───Data_harmonised
    │       │
    │       └───Data_merged
    │       │
    │       └───Data_with_chronologies
    │       │
    │       └───Neotoma_processed
    │       │   │
    │       │   └───Neotoma_chron_control
    │       │   │
    │       │   └───Neotoma_dep_env
    │       │   │
    │       │   └───Neotoma_meta
    │       │
    │       └───Private
    │ 
    └───Outputs
        │
        └───Data
        │
        └───Figures
        │   │
        │   └───Chronology
        │   │
        │   └───Pollen_diagrams
        │   
        └───Tables
            │
            └───Meta_and_references

## Descripton of individual steps <a name="steps"></a>

Here we focus on the scripts within the `R/01_Data_processing` folder
representing all steps needed for data processing from data obtaining to
the final dataset compilation, organised in these sections:

-   I. Data sourcing: `01_Neotoma_source`- Retrieve and process data
    from Neotoma

-   2.  Data sourcing: `02_Private_source` - Process data from private
        datasets (optional)

-   3.  Initial data processing: `03_Merging_and_geography` - Merge data
        sources, filter out duplicates, and assign values based on
        geographical location

-   4.  Chronologies: `04_Chronologies`- Prepare chronology control
        tables, calculate age-depth models, and predict ages for levels

-   V. Harmonisation: `05_Harmonisation` - Prepare all harmonisation
    tables and harmonise pollen taxa

-   6.  Data filtering: `06_Main_filtrering.R` - Filter out levels and
        sequences based on user-defined criteria

-   7.  Outputs: `07_Outputs` - Save the final outputs including dataset
        compilation, pollen diagrams, and metadata information

More detailed information for each individual script can be found on
[FOSSILPOL
website](https://www.nicepng.com/png/detail/137-1379308_website-work-in-progress.png)

## Getting help <a name="help"></a>

If you encounter any issues using this workflow, please use the
repository’s **Issue** tracker.

Consider the following steps before and when opening a new Issue:

1.  Have you searched for similar issues that may have been already
    reported? The issue tracker has a filter function to search for
    keywords in open Issues. You can narrow down the search using
    `labels`:label: as filters. See
    [Labels](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels)
    for more information. As a general rule, we don’t assign issues to
    anyone.
2.  Click on the green **New issue** button in the upper right corner,
    and describe your problem as detailed as possible. The issue should
    state what the problem is, what the expected behaviour should be,
    and, maybe, suggest a solution. Note that you can also attach files
    or images to the issue.
3.  Select a suitable `label`:label: from the drop-down menu called
    **Labels**.
4.  Click on the green **Submit new issue** button and wait for a reply.

## Collabortion <a name="colab"></a>

Do you think you can improve the workflow? We would love to collaborate
:bangbang:

Here is the recommended process:

1.  Fork the repo so that you can make your changes without affecting
    the original project until you’re ready to merge them. [Guide to
    forking](https://docs.github.com/en/get-started/quickstart/fork-a-repo#fork-an-example-repository)
2.  Commit your updates once you are happy with them. See contributing
    [guide](https://github.com/atom/atom/blob/master/CONTRIBUTING.md#git-commit-messages)
    to for commit messages.
3.  When you’re finished with the changes, create a **pull request**,
    also known as a PR.
    -   Fill in the “Ready for review” template so that we can review
        your PR. This template helps reviewers understand your changes
        as well as the purpose of your pull request.
    -   Don’t forget to [link PR to
        issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue)
        if you are solving one.
    -   Enable the checkbox to [allow maintainer
        edits](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/allowing-changes-to-a-pull-request-branch-created-from-a-fork)
        so the branch can be updated for a merge. Once you submit your
        PR, a HOPE team member will review your proposal. We may ask
        questions or request additional information.
    -   We may ask for changes to be made before a PR can be merged,
        either using suggested changes or pull request comments. You can
        apply suggested changes directly through the UI. You can make
        any other changes in your fork, and then commit them to your
        branch. As you update your PR and apply changes, mark each
        conversation as
        [resolved](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/commenting-on-a-pull-request#resolving-conversations)
    -   If you run into any merge issues, check out this [git
        tutorial](https://lab.github.com/githubtraining/managing-merge-conflicts)
        to help you resolve merge conflicts and other issues.
