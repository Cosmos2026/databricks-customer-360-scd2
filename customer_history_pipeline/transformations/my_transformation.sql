CREATE OR REFRESH STREAMING TABLE workspace.bank_project.customers_scd2_auto;

CREATE FLOW customers_cdc_flow AS AUTO CDC INTO workspace.bank_project.customers_scd2_auto
FROM STREAM(workspace.bank_project.customer_changes)
KEYS (customer_id)
APPLY AS DELETE WHEN operation = 'DELETE'
SEQUENCE BY change_time
COLUMNS * EXCEPT (operation, batch_id)
STORED AS SCD TYPE 2;