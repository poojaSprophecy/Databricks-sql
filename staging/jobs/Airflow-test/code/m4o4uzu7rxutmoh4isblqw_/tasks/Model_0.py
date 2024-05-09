from m4o4uzu7rxutmoh4isblqw_.utils import *

def Model_0():
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    dbt_props_cmd = ""

    if "run_profile":
        dbt_props_cmd = " --profile run_profile"

    return BashOperator(
        task_id = "Model_0",
        bash_command = f'''$PROPHECY_HOME/run_dbt.sh "{"; ".join(["dbt run" + dbt_props_cmd, "dbt test" + dbt_props_cmd])}"''',
        env = {
          "DBT_PROFILE_SECRET": "ufAXSwzXMaZrxReWv_LNf", 
          "GIT_TOKEN_SECRET": "rB4uSzfSJFpYHxVQeoWiOA_", 
          "GIT_ENTITY": "branch", 
          "GIT_ENTITY_VALUE": "dev", 
          "GIT_SSH_URL": "https://github.com/poojaSprophecy/Databricks-sql", 
          "GIT_SUB_PATH": "staging"
        },
        append_env = True,
    )
