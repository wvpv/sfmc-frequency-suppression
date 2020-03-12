select
  a.subscriberid
, a.subscriberkey
, count(*) as SendCount
from _Sent a
inner join _Job j on j.jobid = a.jobid
where 1=1
and j.sendClassificationType = 'Default Commercial'
and j.TestEmailAddr is null
and j.Category != 'Test Send Emails'
and j.EmailSubject not Like '%test%'
and a.eventDate >= convert(date, getDate()-7)
group by
a.subscriberid
, a.subscriberkey
having count(*) > 0
/* name: Subscriber_Activity_Summary_Sends */
/* target: Subscriber_Activity_Summary */
/* action: overwrite */