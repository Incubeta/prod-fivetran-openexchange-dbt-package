SELECT day,currency_code,ex_rate FROM {{source('openexchange_rates', 'openexchange_report-v1')}};
