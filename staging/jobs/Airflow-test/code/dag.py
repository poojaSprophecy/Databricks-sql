import os
import sys
import pendulum
from datetime import timedelta
import airflow
from airflow import DAG
from airflow.models.param import Param
from airflow.decorators import task
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from m4o4uzu7rxutmoh4isblqw_.tasks import Model_0
PROPHECY_RELEASE_TAG = "__PROJECT_ID_PLACEHOLDER__/__PROJECT_RELEASE_VERSION_PLACEHOLDER__"

with DAG(
    dag_id = "M4o4Uzu7RxUTMoh4isBLqw_", 
    schedule_interval = "0/5 * * * *", 
    default_args = {"owner" : "Prophecy", "ignore_first_depends_on_past" : True, "do_xcom_push" : True, "pool" : "E0oymhcy"}, 
    start_date = pendulum.today('UTC'), 
    end_date = pendulum.datetime(2024, 5, 30, tz = "UTC"), 
    catchup = False, 
    max_active_runs = 1, 
    tags = []
) as dag:
    Model_0_op = Model_0()
