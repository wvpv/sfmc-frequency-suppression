select
s.EmailAddress [Email Address]
from Subscriber_Activity_Summary sas
inner join ent._Subscribers s on s.subscriberid = sas.subscriberid
where 1=1
and sas.sendCount > 3
and s.EmailAddress not like '%degdigital.com'
/* name: Daily_Frequency_Suppression */
/* target: Daily_Frequency_Suppression */
/* action: overwrite */