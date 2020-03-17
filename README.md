# SFMC Frequency Suppression

# Purpose

The goal of this solution is to implement a weekly frequency suppression scheme with as little configuration/disruption as possible.  Utilizing Marketing Cloud's built-in auto-suppression reduces the level of effort since you are not required to manually update all send definitions in order to implement this suppression in your account.

In most cases, frequency suppression requires that you keep track of how many emails are being sent to each subscriber.  There's not a organic source for that other than the [system data views](https://help.salesforce.com/articleView?id=mc_as_data_views.htm&type=5) or [tracking extract](https://help.salesforce.com/articleView?id=mc_as_tracking_extract_output.htm&type=5) data.  Relying on a large window of data from the system data views is generally not advisable due to their poor performance, but limiting the scope of queries to the previous seven days mitigates some of that risk.

The notable part of this solution is the creation of the initial **Daily_Frequency_Suppression** query.  Auto-Suppression data extensions are not target-able in the interface, but you can target them if you create the query activity using the SFMC API in a CloudPage.  Once the query is created and is targeting the Auto-Suppression data extension, it can be modified to implement any criteria to satisfy the suppression requirements.

The frequency cap logic/threshold is set in the **Daily_Frequency_Suppression** query.

# Steps to use

1. Create a **Subscriber_Activity_Summary** data extension
    - **SubscriberID**, Number, Primary Key
    - **SubscriberKey**, Text(254), Primary Key
    - **SendCount**, Number, nullable, default: 0
    - **OpenCount**, Number, nullable, default: 0
    - **ClickCount**, Number, nullable, default: 0
    - **RefreshDate**, Date, nullable, default: today's date
2. Create a **Daily_Frequency_Suppression** auto-suppression data extension.
    - Browse to `Admin > Send Management > Auto-Suppression Configuration`.
    - Create a new suppression data extension named **Daily_Frequency_Suppression**. Use this name for both the name and external key.
    - Add these columns:
        + **Email Address**, EmailAddress, required
        + **Date Added**, Date, required
    - Select your Commercial CAN-SPAM Classification.
    - **Important**: Review all of your triggered send definitions to ensure that the queues of any paused queries have been purged.
3. Create a **Daily_Frequency_Suppression_Whitelist** data extension
    - **EmailAddress**, Email Address, Primary Key
    - **InsertDate**, Date, nullable, default: today's date
4. Create a CloudPage using the contents of `create_initial_auto_suppression_query.js`
5. Publish and view the CloudPage and confirm that the Query has been created
6. Modify the query and update it with the contents of `daily_frequency_suppression.sql`
7. Upload and import any email addresses to exclude from the suppression into the **Daily_Frequency_Suppression_Whitelist** data extension.
8. Set up an Automation with these steps and schedule it to run daily.
    1. Query Activity: **subscriber_activity_summary_sends**
    2. Query Activity: **subscriber_activity_summary_opens**
    3. Query Activity: **subscriber_activity_summary_clicks**
    4. Query Activity: **daily_frequency_suppression**
9. Start the automation.

