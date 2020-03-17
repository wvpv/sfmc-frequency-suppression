select
s.EmailAddress [Email Address]
from Subscriber_Activity_Summary sas
inner join ent._Subscribers s on s.subscriberid = sas.subscriberid
where 1=1
and sas.sendCount > 3
and s.EmailAddress not like '%degdigital.com'
and not exists (

    select top 1 w.*
    from Daily_Frequency_Suppression_Whitelist w
    where w.EmailAddress = s.EmailAddress

)
/* name: Daily_Frequency_Suppression */
/* description: selects subscribers who are above the weekly send threshold, excluding those in the whitelist */
/* target: Daily_Frequency_Suppression */
/* action: overwrite */