- dbt --version         check the version and the adaptor for the database you want to connect!
- dbt debug             verfiy your connection to your data warehouse
- dbt clean             removes your target folder (the internal state of dbt, manifest.json) as well as dbt_packages dependencies
- dbt ls                it prints all models and files dbt can see and work with
- dbt deps              it checks the installed packages for updates
- dbt parse             validate yaml files only but does not check SQL files!
- dbt complie           render Jinja to SQL files and only in dbt fusion also check SQL syntax
- dbt run               run or materialize the models 
- dbt test              run all the tests or -select specific model (to run its related tests)
- dbt show              what would a model produce
- dbt build             runs dbt seed, dbt run, dbt snapshot, dbt test in the same order mentioed

- dbt run --empty                       practically executes dbt run with LIMIT 0 on all models
                                        this is a fast technic to run models by parsing SQL and yaml files without data
- dbt run --sample <time expression>    samples data based on a time range

-- While you are in you venv environment and under dbt-core install:
    --  pip install dbt-autofix
    and then run: dbt-autofix to upgrade your project and make it compatible with dbt-fusion
