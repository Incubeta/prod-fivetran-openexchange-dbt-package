# Openexchange dbt Package

Welcome to the Openexchange dbt Package! This repository provides a dbt package for transforming and modeling data from the Openexchange API via Fivetran.

---

## Getting Started  

### Prerequisites  
- A working **dbt** installation
- Fivetran Openexchange connector set up and syncing data to your data warehouse

---
### Installation & Setup  

1. **Add the Package to Your `packages.yml`**  
   ```yaml
   packages:
     - git: "https://github.com/incubeta/prod-fivetran-openexchange-dbt-package.git"
       revision: main # or specify a version tag
   ```

2. **Run `dbt deps` to Install the Package**  
   ```bash
   dbt deps
   ```

3. **Configure Required Variables**  
   Add the following variables to your `dbt_project.yml` file:
   ```yaml
   vars:
     openexchange_rates_database: "your_gcp_project_id"  # GCP project ID
     openexchange_rates_schema: "your_dataset_name"      # BigQuery dataset name
   ```

4. **Run the Models**  
   ```bash
   dbt run --select openexchange  # Run all openexchange models
   dbt test --select openexchange # Test all openexchange models
   ```

5. **Using the Model in Your Project**  
   This package provides a staging model that you can reference in your own models:

   ```sql
   -- Example: Create a model that uses the openexchange staging model
   WITH exchange_rates AS (
     SELECT * FROM {{ ref('stg_openexchange_rates__openexchange_report_v1') }}
   )
   
   SELECT 
     date,
     currency,
     rate,
     -- Your transformations here
   FROM exchange_rates
   ```

## Required Variables

This package requires the following variables to be set in your `dbt_project.yml` file:

- **openexchange_rates_database**: The GCP project ID where your Openexchange data is stored
- **openexchange_rates_schema**: The BigQuery dataset name containing the Openexchange data

Example configuration:
```yaml
vars:
  openexchange_rates_database: "my-gcp-project-id"
  openexchange_rates_schema: "fivetran_openexchange"
```

## Available Models

This package provides the following staging model that you can reference in your dbt project:

- **stg_openexchange_rates__openexchange_report_v1**: The main staging model containing currency exchange rate data

To reference this model in your own dbt models, use:
```sql
{{ ref('stg_openexchange_rates__openexchange_report_v1') }}
```

---

## Package Structure  
```
openexchange-dbt-package/
├── models/                # dbt models for Openexchange data
├── macros/                # Custom dbt macros
├── tests/                 # Test files for models
├── dbt_project.yml        # Package configuration file
├── README.md              # Package documentation
└── packages.yml           # Package dependencies
```

---

## Best Practices  

- **Modularity:** Keep models organized by connector and transformation stage.  
- **Version Control:** Use feature branches for development and submit pull requests for code review.  
- **Documentation:** Add descriptions and comments to models and macros for better project maintainability.  

---

## Documentation  

- [dbt Documentation](https://docs.getdbt.com/) – Learn more about dbt features, setup, and usage.  
- [Fivetran Openexchange Connector Documentation](https://fivetran.com/docs/applications/openexchange) – Learn about the Fivetran Openexchange connector.

---

## Contributing  

We welcome contributions! Please submit a pull request or open an issue for any suggestions or improvements.  

---


**Happy Currency Converting!** 💱
