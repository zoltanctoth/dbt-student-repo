{% macro drop_dev_schemas() %}

    {# 
        Use the resolved target schema as the prefix 
        Example:
        DBT_ALI
        DBT_DEV
        DBT_FEATURE_X
    #}

    {% set prefix = target.schema | upper %}

    {# 
        Safety guard:
        Only allow dropping schemas that start with DBT_
        Prevent accidental deletion of PROD/STAGING schemas
    #}

    {% if not prefix.startswith('DBT_') %}

        {{ exceptions.raise_compiler_error(
            "Refusing to drop schemas: target.schema (" ~ target.schema ~ ") does not start with DBT_"
        ) }}

    {% endif %}

    {{ log("* drop_dev_schemas: Looking for schemas with prefix: " ~ prefix, info=True) }}

    {# Find all schemas matching the prefix #}

    {% set results = run_query(
        "
        SELECT schema_name
        FROM information_schema.schemata
        WHERE schema_name ILIKE '" ~ prefix ~ "%'
        "
    ) %}

    {# Drop each matching schema #}

    {% if execute %}

        {% set schemas = results.columns[0].values() %}

        {% for schema in schemas %}

            {{ log("Dropping schema: " ~ schema, info=True) }}

            {% do run_query(
                "DROP SCHEMA IF EXISTS " ~ schema ~ " CASCADE"
            ) %}

        {% endfor %}

        {% if schemas | length == 0 %}

            {{ log("No matching schemas found.", info=True) }}

        {% endif %}

    {% endif %}

{% endmacro %}